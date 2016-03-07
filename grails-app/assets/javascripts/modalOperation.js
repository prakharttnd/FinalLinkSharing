("#createTopic").validate({
    rules: {
        name: {
            required: true,
            minlength: 5
        }
    },
    submitHandler: function (form) {
        var isValidForm = ('#createTopic').valid();
        if (isValidForm) {
            var topic = {
                name: $('#name').val(),
                visibility: $('#visibility').val()
            }

            $.post(form.action, topic, onTopicSave);
        }
    }
});

var onTopicSave = function (topic) {
    console.log(topic);
}