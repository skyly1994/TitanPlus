Zepto(function($){
    var images =$('img[data-gif]');
    images.wrap('<div class="gif-player"></div>');
    images.parent().append('<div class="gif-play-button"><span class="gif-play-button-inner"></span></div>');
    $(document).on('click','.gif-player',function(){
        var player=$(this);
        var img=$(this).children('img');
        var jpg=img.attr('data-jpg');
        var gif=img.attr('data-gif');
        var type=img.attr('data-type');
        var button=$(this).children('.gif-play-button');
        if(jpg==null||type=='jpg'){
            img.attr('data-jpg',img.attr('src'));
            player.addClass("loading");
            img.attr('src',gif);
            img.on('load',function(){
                player.removeClass('loading');
            });
            img.attr('data-type','gif');
            button.addClass('enable');
        }else{
            img.attr('src',jpg);
            img.attr('data-type','jpg');
            button.removeClass('enable');
        }

    });
});