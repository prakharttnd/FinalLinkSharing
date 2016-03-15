package com.ttnd.linksharing

class ResourceRatingController {

    def save() {
        long id = params.long("id")
        ResourceRating resourceRating = ResourceRating.findOrCreateByCreatedByAndResource(session.user, Resource.load(id))
        String score = params.rating
        resourceRating.score = Integer.parseInt(score)
        if (resourceRating.save(flush: true)) {
            flash.message = "Resource rated with $score stars"
        } else {
            flash.error = "Please try later"
        }
        redirect(controller: 'resource', action: 'show', id: id)
    }
}
