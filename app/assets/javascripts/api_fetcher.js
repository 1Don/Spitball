$(document).on("turbolinks:load", function(){
  /* var current_url = window.location.pathname;
  if (current_url == "/wads"){
    $.ajax({
      url: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=96eeb3aac3e6459189d7d43e92b484c6",
      type: "GET",
      dataType: "JSON",
      success: function(data){
        console.log("successfull news api call")
        data["articles"].forEach(function(item){news_api(item)})
      }
    })
  }
  var news_api = function(article){
    var article_url = article["url"]
    var article_title = article["title"]
    $("#news").prepend(`
      <div class="mb-2">
        <a class="profile-link" href="${article_url}" target="_blank"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/TechCrunch_logo.svg/2000px-TechCrunch_logo.svg.png" class="small-image"> ${article_title}</a>
      </div>
      `)
  } */
})
