#!/usr/bin/env bash
cat <<EOT
<html>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <head>
    <title>PhishOD &beta;</title>
  </head>
  <body>
    <ul>
      <h2 id="Apps">PhishOD &beta; Build #${BUILD_NUMBER}</h2>
      <p>You need to open this page (<a href="http://alecgorge.com/phish/beta/">http://alecgorge.com/phish/beta/</a>) on your phone.</p>
      <li><a href="itms-services://?action=download-manifest&url=https%3A%2F%2Fci.alecgorge.com%2Fjob%2FPhishOD%2F${BUILD_NUMBER}%2Fartifact%2Fipa%2FPhishODBeta.plist">Install PhishOD &beta; #${BUILD_NUMBER}</a></li>

      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-27002013-2', 'auto');
        ga('send', 'pageview');
      </script>
      <script>
        function iOSversion() {
          if (/iP(hone|od|ad)/.test(navigator.platform)) {
            // supports iOS 2.0 and later: <http://bit.ly/TJjs1V>
            var v = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/);
            return [parseInt(v[1], 10), parseInt(v[2], 10), parseInt(v[3] || 0, 10)];
          }
        }

        ver = iOSversion();

        if (ver[0] < 7) {
          alert('PhishOD Beta is only supported on devices running iOS 7 or later.');
        }
      </script>
    </ul>
  </body>
</html>
EOT