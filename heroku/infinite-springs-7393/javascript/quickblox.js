/*
 * Javascript wrapper for QuickBlox REST API.
 */
function Quickblox(params) {
	var server = params.server;
	var appId = params.appId;
	var ownerId = params.ownerId;
	var authKey = params.authKey;
	var authSecret = params.authSecret;
	
	var proxy = new Proxy('proxy.php');
		
	var qbObj = {
		server 		: server,
		appId 		: appId,
		ownerId 	: ownerId,
		authKey 	: authKey,
		authSecret 	: authSecret,
		signature 	: null,
		token 		: null,
		
		auth 		: _auth,
		userAuth 	: _userAuth,
		getAllUsers : _getAllUsers,
		getUserByExternalId : _getUserByExternalId,
		getUserByFacebookId : _getUserByFacebookId,
		addUser 	: _addUser,
		addPlace 	: _addPlace,
		//getPlace 	: _getPlace,
		
		getPlaces : _getPlaces,
		//getPlacesByUserId : _getPlacesByUserId,
		
		/*addPlaceForUserId : _addPlaceForUserId,*/
		getUserById : _getUserById,
		
		proxy 		: proxy,
		ADMIN_SERVICE_PREFIX : 'admin',
		USERS_SERVICE_PREFIX : 'users',
		LOCATION_SERVICE_PREFIX : 'location',
		PROTOCOL : 'http'
	};
	
	qbObj.signature = new Signature(qbObj);
	
	_qb = qbObj;
	
	return qbObj;
};

var _qb = null;

function _auth() {
	console.log('[DEBUG] _auth');
	
	var prefix = this.ADMIN_SERVICE_PREFIX;
	var s = this.signature;
	 
	var request = this.PROTOCOL + '://' + prefix + '.' + this.server + '/auth';
	var data = 'app_id=' + this.appId + 
		'&auth_key=' + this.authKey + 
		'&nonce=' + s.nonce + 
		'&timestamp=' + s.timestamp + 
		'&signature=' + s.value
	
	console.log('[DEBUG] _auth sends request: ' + request);
	console.log('[DEBUG] _auth sends data: ' + data);

	var token = null;
	
	this.proxy.post({
		request 	: request,
		data 		: data,
		success 	: function(response) {
			token = $(response).find('token').text();
		}
	});
	
	this.token = token;
	
	console.log('[DEBUG] _auth: qb object ->');
	console.log(this);
}

function _userAuth(params) {
	console.log('[DEBUG] _userAuth(params) ->');
	console.log(params);
	
	var login = params.login;
	var password = params.password;

	var prefix = _qb.USERS_SERVICE_PREFIX;
	var request = this.PROTOCOL + '://' + prefix + '.' + _qb.server + '/users/authenticate';
	var data = 
		'user[owner_id]=' + _qb.ownerId + 
		'&login=' + login + 
		'&password=' + password +
		'&token=' + _qb.token;
	
	var userAuth = null;
	
	_qb.proxy.post({
		request 	: request,
		data 		: data,
		success 	: function(r) {
			userAuth = r;
		},
		error 		: function() {
			
		}
	});
	
	return userAuth;
}

function _getAllUsers(params) {
	var perPage = '';
	var page = '';
	if (params.perPage) {
		perPage = '&per_page=' + params.perPage;
	}
	if (params.page) {
		page = '$page=' + params.page;
	}
	
	console.log('getting all users');
	
	var prefix = this.USERS_SERVICE_PREFIX;
	var request = this.PROTOCOL + '://' + prefix + '.' + this.server + '/users?token=' + this.token + perPage + page;
	
	console.log('request = ' + request);
	
	var result = null;
	
	this.proxy.get({
		request : request,
		success : function(response) {
			result = response;
		}
	});
	return result; 
}

function _getUserByExternalId(extId) {
	console.log('[DEBUG] _getUserByExternalId(%s)', extId);

	var prefix = this.USERS_SERVICE_PREFIX;
	
	// users.{server}/users/external/1438556014.xml?token=b69d7cf74d450b2ca5dd61f17d72b91776a4888e
	var request = this.PROTOCOL + '://' + prefix + '.' + this.server + '/users/external/' + extId + '.xml?token=' + this.token;
	
	var user = null;
	
	this.proxy.get({
		request : request,
		success : function(r) {
			if (r != '') {
				user = response;
			}
		}
	});
	
	return user; 
}

function _getUserByFacebookId(fbId) {
	console.log('[DEBUG] _getUserByFacebookId(%s)', fbId);

	var prefix = this.USERS_SERVICE_PREFIX;
	
	// users.{server}/users/by_facebook_id.xml?facebook_id=1438556012&token=b69d7cf74d450b2ca5dd61f17d72b91776a4888e
	var request = this.PROTOCOL + '://' + prefix + '.' + this.server + '/users/by_facebook_id.xml?facebook_id=' + fbId + '&token=' + this.token;
	
	var user = null;
	
	this.proxy.get({
		request : request,
		success : function(r) {
			console.log('=>>>>>>>>SUCESS');
			user = r;
		},
		error : function() {
			console.log('=>>>>>>>>ERROR');
		}
		
	});
	
	return user; 
}

function _addUser(params) {
	var login = params.login;
	var password = params.password;
	var externalUserId = params.externalUserId;
	var facebookId = params.facebookId;
	
	var fullName = '';
	if (params.fullName) {
		fullName = '&user[full_name]=' + params.fullName;
	} 
	
	var prefix = this.USERS_SERVICE_PREFIX;

	var request = this.PROTOCOL + '://' + prefix + '.' + this.server + '/users';
	var data = 
		'user[owner_id]=' + this.ownerId +  
		'&user[login]=' + login + 
		'&user[password]=' + password + 
		'&token=' + this.token +
		fullName;
	if (externalUserId != null) {
		data += '&user[external_user_id]=' + externalUserId;
	}
	if (facebookId != null) {
		data += '&user[facebook_id]=' + facebookId;
	}
		
	var user = null;
		
	this.proxy.post({
		request 	: request,
		data 		: data,
		success 	: function(r) {
			user = r;
		},
		error 		: function(jqXHR, textStatus, errorThrown) {
			console.log('[ERROR] ->');
			console.log(jqXHR); 
		}
	});
	
	return user;
}

function _addPlace(params) {
	var lat = params.lat;
	var lng = params.lng;
	
	var status = '';
	if (params.status != null) {
		status = '&geo_data[status]=' + params.status; 
	}

	var prefix = _qb.LOCATION_SERVICE_PREFIX;

	var request = this.PROTOCOL + '://' + prefix + '.' + _qb.server + '/geodata';
	var data = 
		'&geo_data[latitude]=' + lat + 
		'&geo_data[longitude]=' + lng + 
		'&token=' + _qb.token + 
		status;
	
	console.log('request: ' + request);
	console.log('data: ' + data);
	
	console.log('adding new place...');
	
	var place = null;
	
	_qb.proxy.post({
		request 	: request,
		data 		: data,
		success 	: function(r) {
			place = r;
		}
	});
	
	return place;
}

function _getPlaces(params) {
	console.log('[DEBUG] _getAllPlaces_e(params) ->');
	console.log(params);
	
	var lastOnly = '';
	if (params.lastOnly) {
		lastOnly = '&last_only=1';
	}
	var userId = '';
	if (params.userId) {
		userId = '&user.id=' + params.userId; 
	}
	var status = '';
	if (params.status) {
		status = '&status=1';
	}
	var sortBy = '';
	if (params.sortBy) {
		sortBy = '&sort_by=' + params.sortBy;
	} 
	var pageSize = '';
	if (params.pageSize) {
		pageSize = '&page_size=' + params.pageSize;
	}
	
	var prefix = _qb.LOCATION_SERVICE_PREFIX;
	var request = _qb.PROTOCOL + '://' + prefix + '.' + _qb.server + '/geodata/find.xml?token=' + _qb.token + lastOnly + userId + status + sortBy + pageSize;
	
	var places = null;
	
	_qb.proxy.get({
		async 	: params.async, 
		request : request,
		success : function(r) {
			if (params.callback) {
				params.callback(r);
			} else {
				places = r;
			}
		}
	});
	return places; 
}

function _getUserById(id) {
	var prefix = _qb.USERS_SERVICE_PREFIX;
	var request = this.PROTOCOL + '://' + prefix + '.' + _qb.server + '/users/' + id + '.xml?token=' + _qb.token;
	
	var user = null;
	
	_qb.proxy.get({
		request : request,
		success : function(response) {
			user = response;
		}
	});

	return user;
}

/* Utils
 * ===============================*/

function Utils() {
	return {
		randInt : function (n) {
			var max = 100; 
			if (n != null) {
				max = n;
			}
			return Math.floor(Math.random() * max);
		},
		unixTimestamp : function () {
			return Math.round((new Date()).getTime() / 1000);
		},
		numIdHash : function (id) {
		    var alphabet = 'abcdefghij';
		    var n = id.length;
		    
		    var result = '';
		    for (var i = 0; i < n; i++) {
		        var c = parseInt(id.charAt(i));
		        result += alphabet.charAt(c);
		    }
		    return result;
		}
	};
}

var utils = new Utils();

/* Proxy
 * ===============================*/

function Proxy(path) {
	var proxyObj = {
		path 	: path,
		get 	: proxy_get,
		post 	: proxy_post 
	}
	return proxyObj; 
}

function proxy_get(params) {
	console.log('[DEBUG] proxy_get(params) ->');
	console.log(params);

	var u = escape(params.request);
	var xml = null;
	var async = false;
	if (params.async) {
		async = true;
	}
	
	console.log(u);

	$.ajax({
		type 	: "GET",
		cache 	: false,
		async 	: async,
		url 	: this.path,
		data 	: "url=" + u,
		success : params.success,
		error	: params.error
	});
}

function proxy_post(params) {
	console.log('[DEBUG] proxy_post(params) ->');
	console.log(params);
	
	var r = escape(params.request);
	var d = escape(params.data);
	var query = 'type=POST&url=' + r + '&data=' + d; 
	
	$.ajax({
		type 		: 'GET',
		cache 		: false,
		async 		: false,
		url 		: this.path,
		data 		: query,
		success 	: params.success,
		error 		: params.error,
		complete 	: function(jqXHR, textStatus) {
			console.log('[DEBUG] REQUEST COMPLETED ->');
			console.log(jqXHR);
		} 
	});
};

/* Signature
 * ===============================*/

function Signature(qbObj) {
	var nonce = utils.randInt();
	var timestamp = utils.unixTimestamp();

	var message = 'app_id=' + qbObj.appId + '&auth_key=' + qbObj.authKey + '&nonce=' + nonce + '&timestamp=' + timestamp;
	var secret = qbObj.authSecret;
	var hmac = Crypto.HMAC(Crypto.SHA1, message, secret);
	
	var signatureObj = {
		nonce 		: nonce,
		timestamp 	: timestamp,
		value 		: hmac
	};
	
	return signatureObj; 
}