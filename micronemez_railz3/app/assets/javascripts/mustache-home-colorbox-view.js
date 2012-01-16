//mustache
var video_tmpl = "{{title}} spends {{calc}}";

var view = {
  title: "Joe",
  calc: function () {
    return 2 + 4;
  }
};

var $mcrnmz_clrbx = Mustache.render(video_tmpl, view);
