(function() {
    /**
     * Utility for Cookies
     * @namespace cookies
     * @author Nisarg Jhaveri <nisarg.jhaveri@students.iiit.ac.in>
     *
     * Originally written for Felicity '15 website
     */
    var cookies = {
        /**
         * Add or update cookie
         *
         * @memberof cookies
         *
         * @param {string} name - Name of the cookie
         * @param {string} value - Value to be set
         * @param {number} expiry - Expiry of cookie in hours (i.e expire after this many hours)
         * @param {string} [path] - Path for the cookie
         */
        set: function( name, value, expiry, path ) {
            var ex = new Date();
            ex.setTime( ex.getTime() + ( expiry * 60 * 60 * 1000 ) );
            var expires = "expires=" + ex.toUTCString();
            document.cookie = name + "=" + value + "; " + expires + ( path ? '; path=' + path : '' );
        },
        /**
         * Get required cookie value
         *
         * @memberof cookies
         *
         * @param {string} name - Name of the cookie
         *
         * @returns {string} Value of the cookie
         */
        get: function( name ) {
            name = name + '=';
            var cookieList = document.cookie.split( ';' );
            var cookie;
            for ( cookie in cookieList ) {
                cookie = cookieList[cookie].trim();
                if ( cookie.substr( 0, name.length ) == name ) {
                    return cookie.substr( name.length );
                }
            }
        },
        /**
         * Remove a cookie
         *
         * @memberof cookies
         *
         * @param {string} name - Name of the cookie
         */
        remove: function ( name ) {
            document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
        }
    };

    var areCookiesDisabled = function () {
        cookies.set('testCookie', 'true', 1);
        var value = cookies.get('testCookie');
        if (value !== undefined) {
            cookies.remove('testCookie');
            return false;
        }
        return true;
    };

    var emailDomains = [
        'iiit.ac.in',
        'students.iiit.ac.in',
        'research.iiit.ac.in',
    ];
    var onLoad = function() {
        var emailBox = document.getElementById('username');
        var passwordBox = document.getElementById('password');
        var capslockOnMessage = document.getElementById('capslock-on');

        // Check if cookies is disabled
        if (areCookiesDisabled()) {
            document.getElementById('cookiesDisabled').style.display = 'block';
        }

        // Focus email textbox
        emailBox.focus();

        // Autocomplete email domain
        emailBox.addEventListener('keyup', function (e) {
            if ((e.which >= 'A'.charCodeAt(0) && e.which <= 'Z'.charCodeAt(0) )
            || (e.which >= 'a'.charCodeAt(0) && e.which <= 'z'.charCodeAt(0) )) {
                var reg = new RegExp('^' + emailBox.value.split('@')[1]);
                var allowed = emailDomains.filter(function(domain) {
                    return reg.test(domain);
                });
                if (allowed.length == 1) {
                    emailBox.value = emailBox.value.split('@')[0] + '@' + allowed[0];
                    passwordBox.focus();
                }
            }
        });

        // Show warning if capslock is on
        passwordBox.addEventListener('keypress', function(e) {
            var s = String.fromCharCode( e.which );
            if ( s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey ) {
                capslockOnMessage.style.display = 'inline';
            } else {
                capslockOnMessage.style.display = 'none';
            }
        });
    };

    window.addEventListener('load', onLoad);
})();
