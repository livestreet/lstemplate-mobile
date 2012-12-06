<?php

$config = array();

$config['view']['theme'] = 'default';


$config['head']['default']['js']  = array(
	"___path.root.engine_lib___/external/html5shiv.js" => array('browser'=>'lt IE 9'),
	"___path.root.engine_lib___/external/jquery/jquery.js",
	"___path.root.engine_lib___/external/jquery/jquery-ui.js",
	"___path.root.engine_lib___/external/jquery/jquery.notifier.js",
	"___path.root.engine_lib___/external/jquery/jquery.scrollto.js",
	"___path.root.engine_lib___/external/jquery/jquery.rich-array.min.js",
	"___path.root.engine_lib___/external/jquery/markitup/jquery.markitup.js",
	"___path.root.engine_lib___/external/jquery/jquery.form.js",
	"___path.root.engine_lib___/external/jquery/jquery.jqplugin.js",
	"___path.root.engine_lib___/external/jquery/jquery.cookie.js",
	"___path.root.engine_lib___/external/jquery/jquery.serializejson.js",
	"___path.root.engine_lib___/external/jquery/jquery.file.js",
	"___path.root.engine_lib___/external/jquery/jquery.placeholder.min.js",
	"___path.root.engine_lib___/external/jquery/jquery.charcount.js",
	"___path.root.engine_lib___/internal/template/js/main.js",
	"___path.root.engine_lib___/internal/template/js/favourite.js",
	"___path.root.engine_lib___/internal/template/js/blocks.js",
	"___path.root.engine_lib___/internal/template/js/talk.js",
	"___path.root.engine_lib___/internal/template/js/vote.js",
	"___path.root.engine_lib___/internal/template/js/poll.js",
	"___path.root.engine_lib___/internal/template/js/subscribe.js",
	"___path.root.engine_lib___/internal/template/js/geo.js",
	"___path.root.engine_lib___/internal/template/js/wall.js",
	"___path.root.engine_lib___/internal/template/js/usernote.js",
	"___path.root.engine_lib___/internal/template/js/comments.js",
	"___path.root.engine_lib___/internal/template/js/blog.js",
	"___path.root.engine_lib___/internal/template/js/user.js",
	"___path.root.engine_lib___/internal/template/js/userfeed.js",
	"___path.root.engine_lib___/internal/template/js/userfield.js",
	"___path.root.engine_lib___/internal/template/js/stream.js",
	"___path.root.engine_lib___/internal/template/js/photoset.js",
	"___path.root.engine_lib___/internal/template/js/toolbar.js",
	"___path.root.engine_lib___/internal/template/js/settings.js",
	"___path.root.engine_lib___/internal/template/js/topic.js",
	"___path.root.engine_lib___/internal/template/js/hook.js",
	"___path.static.skin___/js/template.js?v=2",
	"___path.static.skin___/js/libs/jquery.touchswipe.js",
	"___path.static.skin___/js/libs/jquery.swipegallery.js",
	"___path.static.skin___/js/libs/jquery.fitvids.js",
	"http://yandex.st/share/share.js" => array('merge'=>false),
);


$config['head']['default']['css'] = array(
	"___path.static.skin___/css/reset.css",
	"___path.static.skin___/css/base.css?v=2",
	"___path.root.engine_lib___/external/jquery/markitup/skins/simple/style.css",
	"___path.root.engine_lib___/external/jquery/markitup/sets/default/style.css",
	"___path.static.skin___/css/grid.css",
	"___path.static.skin___/css/common.css",
	"___path.static.skin___/css/text.css",
	"___path.static.skin___/css/forms.css",
	"___path.static.skin___/css/buttons.css",
	"___path.static.skin___/css/navs.css",
	"___path.static.skin___/css/icons.css",
	"___path.static.skin___/css/tables.css",
	"___path.static.skin___/css/topic.css",
	"___path.static.skin___/css/comments.css",
	"___path.static.skin___/css/blocks.css",
	"___path.static.skin___/css/modals.css",
	"___path.static.skin___/css/blog.css",
	"___path.static.skin___/css/profile.css",
	"___path.static.skin___/css/wall.css",
	"___path.static.skin___/css/jquery.notifier.css",
	"___path.static.skin___/css/smoothness/jquery-ui.css",
	"___path.static.skin___/themes/___view.theme___/style.css",
	"___path.static.skin___/css/print.css",
);


return $config;
?>