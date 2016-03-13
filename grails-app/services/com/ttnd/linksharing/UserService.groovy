package com.ttnd.linksharing

import com.ttnd.linksharing.co.LoginCO
import com.ttnd.linksharing.co.UserCO
import com.ttnd.linksharing.dto.EmailDTO
import com.ttnd.linksharing.dto.ResponseDTO
import com.ttnd.linksharing.util.Util
import com.ttnd.linksharing.vo.SubscribedTopicVO
import com.ttnd.linksharing.vo.UserVO
import grails.transaction.Transactional
import org.springframework.context.MessageSource

@Transactional
class UserService {

    def emailService

    MessageSource messageSource

    def isEmailExists(String email) {
        User user = User.findByEmail(email)
        String result = user ? false : true
        return result
    }

    def isUsernameExists(String username) {
        User user = User.findByUsername(username)
        String result = user ? false : true
        return result
    }

    def loginHandler(LoginCO loginCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        try {
            User user = User.createCriteria().get {
                or {
                    eq('email', loginCO.username)
                    eq('username', loginCO.username)
                }
                and {
                    eq('password', loginCO.password)
                }
            }
            if (user) {
                if (user.active) {
                    responseDTO.status = 200
                    responseDTO.object = user
                    responseDTO.message = messageSource.getMessage("valid.login.username.password", [].toArray(), Locale.default)
                } else {
                    responseDTO.status = 200
                    responseDTO.object = null
                    responseDTO.message = messageSource.getMessage("account.not.active", [].toArray(), Locale.default)
                }
            } else {
                responseDTO.status = 201
                responseDTO.message = messageSource.getMessage("invalid.login.username.password", [].toArray(), Locale.default)
                responseDTO.object = null
            }
        } catch (Exception e) {
            log.error "Exception in userservice loginhandler $e"
            responseDTO.status = 500
            responseDTO.message = "Please Try Later"
            return responseDTO
        }
        return responseDTO
    }

    def register(UserCO userCO) {
        ResponseDTO responseDTO = new ResponseDTO()
        User user = new User(userCO.properties)
        if (user.save()) {
            responseDTO.status = 200
            responseDTO.message = messageSource.getMessage("user.register.successfull", [].toArray(), Locale.default)
            responseDTO.object = user
        } else {
            responseDTO.status = 201
            responseDTO.message = user.errors.allErrors.collect { messageSource.getMessage(it, null) }.join(",")
            responseDTO.object = user
        }
        return responseDTO
    }

    def forgetPassword(String email) {
        ResponseDTO responseDTO = new ResponseDTO()
        String newPassword = Util.generateRandomPassword()
        User user = User.createCriteria().get {
            property('id')
            property('active')
            eq('email', email)
        }
        if (user.active) {
            Integer result = User.executeUpdate("update User set password=:password where id=:id", [password: newPassword, id: user.id])
            if (result) {
                List<String> to = [email]
                String subject = messageSource.getMessage("reset.password.subject", [].toArray(), Locale.default)
                String view = "/email/_forgetPassword"
                Map model = ['newPassword': newPassword]
                EmailDTO emailDTO = new EmailDTO(to: to, subject: subject, view: view, model: model)
                emailService.sendMail(emailDTO)
                responseDTO.status = 200;
                responseDTO.message = messageSource.getMessage("reset.password.email.sent", [email].toArray(), Locale.default)
            } else {
                responseDTO.status = 201
                responseDTO.message = messageSource.getMessage("reset.password.save.fail", [].toArray(), Locale.default)
            }
        } else {
            responseDTO.status = 201
            responseDTO.message = messageSource.getMessage("account.not.active", [].toArray(), Locale.default)
        }
        return responseDTO
    }

    def fetchUserInfo(User user) {
        User user1 = User.get(user.id)
        UserVO userVO = new UserVO(username: user1.username, fullName: user1.fullName, photo: user1.photo, numberOfTopics: user1.topics.size(), numberOfSubscriptions: user1.subscriptions.size())
        return userVO
    }

    def fetchUserTopics(User currentUser) {
        List<Topic> topics = Topic.findAllByCreatedBy(currentUser)
        List<SubscribedTopicVO> topicVOs = topics.collect {
            SubscribedTopicVO subscribedTopicVO = new SubscribedTopicVO(topicCreatorId: it.createdBy.id, photo: it.createdBy.photo, topicCreatorUsername: it.createdBy.username, topicId: it.id, topicName: it.name, visibility: it.visibility, numberOfSubscriptions: it.subscriptions.size(), numberOfResources: it.resources.size())
            Subscription subscription = Subscription.findByTopicAndUser(it, currentUser)
            if (subscription) {
                subscribedTopicVO.subscriptionId = subscription.id
                subscribedTopicVO.seriousness = subscription.seriousness
            }
            return subscribedTopicVO
        }
        return topicVOs
    }
}
