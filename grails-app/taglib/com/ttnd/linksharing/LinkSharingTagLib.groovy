package com.ttnd.linksharing

import com.ttnd.linksharing.vo.RecentShareVO
import com.ttnd.linksharing.vo.ResourceVO
import com.ttnd.linksharing.vo.SubscribedTopicVO
import com.ttnd.linksharing.vo.TopicInfoVO
import com.ttnd.linksharing.vo.TrendingTopicVO
import com.ttnd.linksharing.vo.UnreadResourceVO
import com.ttnd.linksharing.vo.UserVO

class LinkSharingTagLib {
    //  static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]
    static namespace = "ls"

    def recentShares = { attrs, body ->
        if (attrs.recent) {
            attrs.recent.each { RecentShareVO recentShareVO ->
                out << render(template: '/shared/recentShareRow', model: [recentShareVO: recentShareVO])
            }
        }
    }

    def timePeriod = { attrs, body ->
        Date date = new Date()
        Date date1 = attrs.date
        use(groovy.time.TimeCategory) {
            def duration = date - date1
            if (duration.days > 0) {
                out << "$duration.days days ago"
            } else if (duration.hours > 0) {
                out << "$duration.hours hour ago"
            } else if (duration.minutes > 0) {
                out << "$duration.minutes minute ago"
            } else {
                out << "$duration.seconds second ago"
            }

        }
    }

    def renderSmallImage = { attrs, body ->
        if (!attrs.photo) {
            String src = assetPath(src: 'defaultimage.jpg')
            out << "<img src='$src' class='img-rounded' height='70px;' width='70px;' alt='dp' style='float: left; margin-left: 20px;'>"
        }

    }

    def renderBigImage = { attrs, body ->
        if (!attrs.photo) {
            String src = assetPath(src: 'defaultimage.jpg')
            out << "<img src='$src' class='img-rounded' height='100px;' width='100px;' alt='dp' style='float: left;'>"
        }
    }

    def renderBigImageMargin = { attrs, body ->
        if (!attrs.photo) {
            String src = assetPath(src: 'defaultimage.jpg')
            out << "<img src='$src' class='img-rounded' height='100px;' width='100px;' alt='dp' style='float: left; margin-left: 20px;'>"
        }
    }

    def userInfo = { attrs, body ->
        if (attrs.userVO) {
            out << render(template: "/user/userInfoHtml", model: [userVO: attrs.userVO])
        }
    }

    def subscribedTopics = { attrs, body ->
        if (attrs.subscribedTopics) {
            attrs.subscribedTopics.each { SubscribedTopicVO subscribedTopicVO ->
                out << render(template: "/user/subscriptionsRow", model: [subscribedTopicVO: subscribedTopicVO])
            }
        }
    }

    def subscribedTopicsControl = { attrs, body ->
        if (attrs.creator == session.user.id || session.user.admin) {
            out << render(template: "/user/subscriptionsAdminCreatorControl", model: [visibility: attrs.visibility, seriousness: attrs.seriousness, topicId: attrs.topicId, subscriptionId: attrs.subscriptionId])
        } else {
            out << render(template: "/user/subscriptionUserControl", model: [seriousness: attrs.seriousness, subscriptionId: attrs.subscriptionId])
        }
    }

    def inboxResources = { attrs, body ->
        if (attrs.unreadResources) {
            attrs.unreadResources.each { UnreadResourceVO unreadResourceVO ->
                out << render(template: '/user/inboxRow', model: [unreadResourceVO: unreadResourceVO])
            }
        }
    }

    def trendingTopics = { attrs, body ->
        if (attrs.trendingTopics) {
            attrs.trendingTopics.each { TrendingTopicVO trendingTopicVO ->
                out << render(template: '/user/trendingTopicRow', model: [trendingTopicVO: trendingTopicVO])
            }
        }
    }

    def topicInfo = { attrs, body ->
        out << render(template: '/topic/topicInfoHtml', model: [topicInfoVO: attrs.topicInfoVO as TopicInfoVO])
    }

    def topicShowUsers = { attrs, body ->
        if (attrs.users) {
            attrs.users.each { UserVO userVO ->
                out << render(template: "/topic/users", model: [userVO: userVO])
            }
        }
    }

    def topicShowPosts = { attrs, body ->
        if (attrs.posts) {
            attrs.posts.each { ResourceVO resourceVO ->
                out << render(template: "/topic/post", model: [resourceVO: resourceVO])
            }
        }
    }

    def resource = { attrs, body ->
        if (attrs.resourceVO) {
            out << render(template: "/resource/resourceHtml", model: [resourceVO: attrs.resourceVO as ResourceVO])
        }
    }

    def resourceLinks = { attrs, body ->
        if (attrs.resourceCreatorId == session.user.id || session.user.admin) {
            out << render(template: '/resource/resourceAdminCreatorLinks', model: [resourceId: attrs.resourceId, description: attrs.description])
        }

    }

    def searchResource = { attrs, body ->
        if (attrs.resources) {
            attrs.resources.each { Resource resource ->
                out << render(template: '/resource/searchRow', model: [resource: resource])
            }
        }
    }

    def markAsReadOrUnreadLink = { attrs, body ->
        if (attrs.id) {
            ReadingItem item = ReadingItem.findByResourceAndUser(Resource.load(attrs.id), session.user)
            if (item) {
                if (item.isRead) {
                    out << "<a href='/readingItem/toggleReadUnread/${attrs.id}' class='toggleReadUnread'>Mark as Unread</a>"
                } else {
                    out << "<a href='/readingItem/toggleReadUnread/${attrs.id}' class='toggleReadUnread'>Mark as Read</a>"
                }
            }
        }
    }
}
