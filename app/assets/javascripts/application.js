// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .

votes = document.getElementsByClassName("upvote_review");


for (var i=0;i<votes.length;i++){
  votes[i].addEventListener('click', function() {
    let vote = { review_id: this.dataset.reviewId, vote_score: true, user_id: this.dataset.userId }
    let request = $.ajax({
      method: 'POST',
      url: this.dataset.url,
      data: vote
    })

    request.done((count) => {

    alert(count); //test alert

    })
  });
}
