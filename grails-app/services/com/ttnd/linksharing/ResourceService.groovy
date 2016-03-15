package com.ttnd.linksharing

import com.ttnd.linksharing.enums.Visibility
import com.ttnd.linksharing.vo.RecentShareVO
import com.ttnd.linksharing.vo.ResourceVO
import com.ttnd.linksharing.vo.TrendingTopicVO
import grails.transaction.Transactional

@Transactional
class ResourceService {

    List<RecentShareVO> fetchRecentShares() {
        List<RecentShareVO> recentShares = Resource.createCriteria().list(max: 5) {
            projections {
                'createdBy' {
                    property('firstName')
                    property('lastName')
                    property('username')
                    property('photo')
                    property('id')
                }
                'topic' {
                    property('name')
                    property('id')
                }
                property('id')
                property('description')
                property('dateCreated')
            }
            'topic' {
                eq('visibility', Visibility.PUBLIC)
            }
            order('dateCreated', 'desc')
        }.collect {
            new RecentShareVO(fullName: it[0] + " " + it[1], username: it[2], photo: it[3], userId: it[4], topicName: it[5], topicId: it[6], resourceId: it[7], description: it[8], dateCreated: it[9])
        }
        return recentShares
    }

    def fetchTrendingTopics(User user) {
        List<TrendingTopicVO> trendingTopics = Resource.createCriteria().list(max: 5) {
            groupProperty('topic', 'topic')
            'topic' {
                eq('visibility', Visibility.PUBLIC)
            }
            count('topic', 'count')
            order('count', 'desc')
        }.collect {
            Subscription subscription = Subscription.findByTopicAndUser(it[0], user)
            if (subscription) {
                new TrendingTopicVO(topicCreatorId: it[0].createdBy.id, photo: it[0].createdBy.photo, topicCreatorUsername: it[0].createdBy.username, topicName: it[0].name, topicId: it[0].id, visibility: it[0].visibility, numberOfSubscriptions: it[0].subscriptions.size(), numberOfPosts: it[0].resources.size(), subscriptionId: subscription.id, seriousness: subscription.seriousness)
            } else {
                new TrendingTopicVO(topicCreatorId: it[0].createdBy.id, photo: it[0].createdBy.photo, topicCreatorUsername: it[0].createdBy.username, topicName: it[0].name, topicId: it[0].id, visibility: it[0].visibility, numberOfSubscriptions: it[0].subscriptions.size(), numberOfPosts: it[0].resources.size(), subscriptionId: 0, seriousness: null)
            }
        }
        return trendingTopics
    }

    def fetchResourceInfo(long id, User user) {
        Resource resource = Resource.get(id)
        ResourceRating resourceRating = ResourceRating.findByCreatedByAndResource(user, resource)
        ResourceVO resourceVO = new ResourceVO(resourceCreatorId: resource.createdBy.id, resourceCreatorName: resource.createdBy.fullName, resourceCreatorUsername: resource.createdBy.username, photo: resource.createdBy.photo, topicId: resource.topic.id, topicName: resource.topic.name, resourceId: resource.id, description: resource.description, dateCreated: resource.dateCreated, resourceClass: resource.class)
        if (resourceVO.resourceClass == LinkResource) {
            resourceVO.url = resource.url
        } else {
            resourceVO.filepath = resource.filepath
        }
        if (resourceRating) {
            resourceVO.score = resourceRating.score
        } else {
            resourceVO.score = 1
        }
        return resourceVO
    }

    def fetchTopPosts(Integer day) {
        def topPosts = ResourceRating.createCriteria().list(max: 5) {
            projections {
                'resource' {
                    'createdBy' {
                        property('firstName')
                        property('lastName')
                        property('username')
                        property('photo')
                        property('id')
                    }
                    'topic' {
                        property('name')
                        property('id')
                    }
                    property('id')
                    property('description')
                    property('dateCreated')
                }
            }
            groupProperty('resource')
            count('resource', 'count')
            order('count', 'desc')
            'resource' {
                ge('dateCreated', new Date() - day)
            }
        }.each {
            log.info "<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
            log.info it
            log.info "<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>"
        }
    }
}