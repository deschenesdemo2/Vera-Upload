#/bin/bash

        #$1 VID
        #$2 VKEY
        #$3 DAST_SCAN_NAME
        #$4 APP_URL

        echo ''
        echo '====== DEBUG START ======'
        echo '[INFO] API-ID: ' $1
        echo '[INFO] API-Key: ' $2
        echo '[INFO] DAST-Scan-Name: ' $3
        echo '[INFO] App-URL: ' $4
        echo '====== DEBUG END ======'
        echo ''

        #Create Credentials File
        echo '[INFO] ------------------------------------------------------------------------'
        echo '[INFO] --- CONFIGURING API CREDENTIALS FILE...'
        echo '[INFO] ------------------------------------------------------------------------'
        echo '[default]' >> credentials.txt
        echo 'veracode_api_key_id='$1 >> credentials.txt
        echo 'veracode_api_key_secret='$2 >> credentials.txt
        mkdir ./.veracode/
        cp -f credentials.txt ./.veracode/credentials
        chmod 755 ./.veracode/credentials
        echo ''

        #Install Veracode Authentication Library
        echo '[INFO] ------------------------------------------------------------------------'
        echo '[INFO ] --- INSTALLING VERACODE AUTHENTICATION LIBRARY...'
        echo '[INFO] ------------------------------------------------------------------------'
        pip install veracode-api-signing || echo "[ERROR] There was a problem Installing Veracode Authentication Library..." | exit 1
        echo ''

        echo '[INFO] ------------------------------------------------------------------------'
        echo '[INFO] --- CREATING JSON FILE...'
        echo '[INFO] ------------------------------------------------------------------------'
        echo  '{' >> da_scan.json
        echo  '  "name": "'$3'",' >> da_scan.json
        echo  '  "scans": [' >> da_scan.json
        echo  '    {' >> da_scan.json
        echo  '      "scan_config_request": {' >> da_scan.json
        echo  '        "target_url": {' >> da_scan.json
        echo  '          "url": "'$4'"' >> da_scan.json
        echo  '        }' >> da_scan.json
        echo  '      }' >> da_scan.json
        echo  '    }' >> da_scan.json
        echo  '  ],' >> da_scan.json
        echo  '  "schedule": {' >> da_scan.json
        echo  '    "duration": {' >> da_scan.json
        echo  '      "length": 1,' >> da_scan.json
        echo  '      "unit": "DAY"' >> da_scan.json
        echo  '    },' >> da_scan.json
        echo  '    "scheduled": true,' >> da_scan.json
        echo  '    "now": true' >> da_scan.json
        echo  '  }' >> da_scan.json
        echo  '}' >> da_scan.json
        echo ''
        cat ./.veracode/credentials
        echo ''
        cat da_scan.json
