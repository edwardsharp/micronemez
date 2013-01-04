// FB settings
var FB_APP_ID = '315055265280158';

// QB settings
var QB_SERVER = 'quickblox.com';
var QB_APP_ID = '1380';
var QB_OWNER_ID = '1380';
var QB_AUTH_KEY = '6g9gNfQYhYFVWDh';
var QB_AUTH_SECRET = 'dnhRxJ45HvczJHr';

// Map settings=45.516587,-122.635038
var MAP_CENTER_LAT = 45.516587;
var MAP_CENTER_LNG = -122.635038;
var MAP_ZOOM = 2;
var MAP_CANVAS = 'qb_map_canvas';

var qbmap = null;

var fbme = null;
var fbmeAvatar = null;
var qb = null;

var qbme = null;
var qbmePlace = null;
var qbmeId = null;
var utils = new Utils();

function init(facebookMe) {
	tabController();
	mapController();
	chatRoomController();
		
	fbme = facebookMe;
	fbmeAvatar = '<img src="http://graph.facebook.com/' + fbme.id + '/picture" alt="" />'

	qb = new Quickblox({
		server 		: QB_SERVER, 
		appId 		: QB_APP_ID,
		ownerId 	: QB_OWNER_ID, 
		authKey 	: QB_AUTH_KEY, 
		authSecret 	: QB_AUTH_SECRET
	}); 
	
	qb.auth();
	
	// Check if user exist in storage.
	qbme = qb.getUserByFacebookId(fbme.id);
	
	console.log('qbme user ->');
	console.log(qbme);
	
	if (qbme == null) {
		console.log('You are not exist');
		addMe();
	} else {
		console.log('You are exist');
		authCurrentUser();

		qbmeId = $(qbme).find('id').text();
	
		qbmePlace = qb.getPlaces({ 
			userId : qbmeId, 
			lastOnly : true 
		});
		
		main();
	}
}

function main() {
	console.log('MAIN !!!!!!!!!!!');
	
	console.log('PLACE=====>>>>>>>');
	console.log(qbmePlace);

	console.log('QBME');
	console.log(qbme);
	
	// var places = getAllPlaces();
	
	getAllPlaces();
	
	/*
	console.log('PLACES=====>>>>>>>');
	console.log(places);
	
	showUsersOnMap(places);
	
	showMeOnMap();
	*/
}

function addMe() {
	console.log('add you first time');

	qbme = qb.addUser({
		login : utils.numIdHash(fbme.id),
		password : utils.numIdHash(fbme.id),
		facebookId : fbme.id,
		fullName : fbme.name
	});
	
	qbmeId = $(qbme).find('id').text();

	authCurrentUser();

	initializeLocation();
}

function authCurrentUser() {
	var auth = qb.userAuth({
		login : utils.numIdHash(fbme.id),
		password : utils.numIdHash(fbme.id)
	});
}

function initializeLocation() {
	console.log('init location first time');
	
	if (fbme.location != undefined && fbme.location.name != undefined) {
		geocode(fbme.location.name, addPlaceFirstTime);
	} else {
		var ip = $('#qb-widget').attr('ip');
		geoip(ip, addPlaceFirstTime);
	}
}

function addPlaceFirstTime(latlng) {
	console.log('add place first time...');

	qbmePlace = qb.addPlace({
		lat : latlng.lat(),
		lng : latlng.lng(),
		status : 'PING?PONG!'
	});
	
	main();
}

function getAllPlaces() {
	console.log('getting all users');
	
	var places = qb.getPlaces({
		async : true,
		sortBy : 'created_at',
		lastOnly : true,
		pageSize : 100,
		callback : showUsersOnMap_cb
	});
}

function mapController() {
	var latlng = new google.maps.LatLng(MAP_CENTER_LAT, MAP_CENTER_LNG);
	
	var mapOptions = {
		zoom : MAP_ZOOM,
		center : latlng,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	};
	
	qbmap = new google.maps.Map(document.getElementById(MAP_CANVAS), mapOptions);
}



/* Map functions*/

var infoWindow = null;

function showMarkerOnMap(placeIndex) {
	var place = markerPlaces[placeIndex];
	
	var qbid = $(place).find('user').find('id').text();
	
	var lat = $(place).find('latitude').text();
	var lng = $(place).find('longitude').text();
	
	var latlng = new google.maps.LatLng(lat, lng);

	var markerImage = null;

	if (qbid == qbmeId) {
		var markerImage = new google.maps.MarkerImage(
			'marker.png',
	    	new google.maps.Size(60, 50),
	    	new google.maps.Point(0,0),
	    	new google.maps.Point(15, 50));
   }
	
	var marker = new google.maps.Marker({
		position : latlng,
		map : qbmap,
		title : "FIXME",
		icon : markerImage
	});
	
	google.maps.event.addListener(marker, 'click', function() {
		markerClickHandler(place, marker);
	});
}

function markerClickHandler(place, marker) {
	var userId = $(place).find('user-id').text();
	var status = $(place).find('status').text();
	var fbId =  $(place).find('facebook-id').text();
	var name =  $(place).find('full-name').text();
	var avatar = '';
	if (status == '') {
		status = 'nothing yet...'
	}
	if (fbId == '') {
		avatar = '<img src="nophoto.png" alt="GENERIC" />'
	} else {
		avatar = getAvatarTag(fbId);
	}
	if (name == '') {
		name = 'Anonymous';
	}
	
	var content = '<div style="min-height:60px; min-width:220px;" class="qb-iw-container" id="qb-iw-container-' + userId + '">' + 
		'<div class="qb-iw-avatar">' + avatar + '</div>' + 
		'<div class="qb-iw-user">' + getFacebookLink(fbId, name) + '</div>' +
		'<div class="qb-iw-status">' + status + '</div>' + 
		'</div>';

	if (infoWindow) infoWindow.close();
	infoWindow = new google.maps.InfoWindow({
		content : content
	});
	infoWindow.open(qbmap, marker);	
}

function geocode(locationString, callback) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode( { 'address': locationString }, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			callback(results[0].geometry.location);
		} else {
			alert("Geocode was not successful for the following reason: " + status);
		}
	});	
}

function geoip(ip, callback) {
	console.log('>>>>> geoip');
	var proxy = new Proxy('proxy.php');
	
	var latlng = null;
	
	if (ip == '') {
		ip = '66.66.66.66'; // FIXME
	}
	
	proxy.get({
		async : true,
		request : 'http://geoip.quickblox.com/?ip=' + ip,
		success : function(r) {
			console.log(r);
			latlng = new google.maps.LatLng($(r).find('latitude').text(), $(r).find('longitude').text());
			console.log(latlng);
			callback(latlng);
		}
	});
}


var markerPlaces = null;

function showUsersOnMap_cb(places) {
	markerPlaces = new Array();
	
	var metmp = null;
	
	$(places).find('geo-datum').each(function(k, v){
		var place = $(v);
		
		var k = markerPlaces.length;
		markerPlaces[k] = place;
		showMarkerOnMap(k);
	});
}

function updateMarkers(obj) {
	var userId = obj.userId;
	var status = obj.status;
	
	if (markerPlaces != null) {
		$(markerPlaces).each(function(k, v){
			var uid = $(v).find('user-id').text();
			var s = $(v).find('status').text();
			if (userId == uid && status != s) {
				$(v).find('status').text(status);
				
				$('#qb-iw-container-' + userId + ' .qb-iw-status').html(status);
			}
		});
	}
}

/* Chat functions */

function chatRoomController() {
	// Frequency of chat udpating.
	var freq = 5000;
	
	console.log('controller started...');
	
	$('#qb-status-message').keyup(function(event){
  		if (event.keyCode == 13) {
    		sendChatMessage();
		}
	});
	
	$('#qb-send-message').click(sendChatMessage);
	
	window.setInterval(updateChat, freq);
}

function updateChat() {
	
	var latestPlaces = qb.getPlaces({
		async : true,
		sortBy : 'created_at',
		pageSize : '15',
		status : true,
		callback : updateChat_cb
	});
}

function updateChat_cb(latestPlaces) {
	$('#qb-chat-room').html('');
	
	var tmpids = new Array();
	
	$(latestPlaces).find('geo-datum').each(function(k, v){
		var place = $(v);
		var placeId = place.find('id:first').text();
		var userId = place.find('user-id').text();
		var status = place.find('status').text();
		var fbId =  place.find('facebook-id').text();
		var name =  place.find('full-name').text();
		if (name == '') {
			name = 'Anonymous';
		}
		
		$('#qb-chat-room').append('<div class="qb-chat-message">' + 
			getAvatarTag(fbId) + 
			'<div class="qb-message-author">' + getFacebookLink(fbId, name) + '</div>' +
			'<div class="qb-chat-message-content">' + status + '</div>' + 
			'</div>');
			
		if ($.inArray(userId, tmpids) < 0) {
			tmpids.push(userId);
			updateMarkers({ userId : userId, status : status });
		}
	});
}

function sendChatMessage() {
	var message = $('#qb-status-message').val();
	$('#qb-status-message').val('');
	
	if (message == '') {
		return false;
	}
	
	var currentLat = $(qbmePlace).find('latitude').text();
	var currentLng = $(qbmePlace).find('longitude').text();
	
	var place = qb.addPlace({
		lat : currentLat,
		lng : currentLng,
		status : message 
	});
	
	updateChat();
}

function getAvatarTag(fbuserId) {
	return '<img src="http://graph.facebook.com/' + fbuserId + '/picture" alt="" />';
}

function getFacebookLink(fbuserId, name) {
	return '<a href="http://www.facebook.com/profile.php?id=' + fbuserId + '">' + name + '</a>';
}

function tabController() {
	$('#qb-map-tab').click(function(){
		$('#qb-chat-tab').removeClass('selected');
		$('#qb-map-tab').addClass('selected');
		$('#qb-map').show();
		$('#qb-chat').hide();
	});
	$('#qb-chat-tab').click(function(){
		$('#qb-map-tab').removeClass('selected');
		$('#qb-chat-tab').addClass('selected');
		$('#qb-chat').show();
		$('#qb-map').hide();
	});
}
