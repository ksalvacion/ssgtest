#!/bin/bash
source config.properties

# Replace default values in template
# Comment out bak if using a machine other than OSX

echo ""
echo "[INFO] Update template with default values"
echo ""

bak=".bak"
enc_backend_url=$(echo -n $dev_backend_url | base64)
enc_backend_url="${enc_backend_url//=/\\\=}"

sed -i $bak "s/${enc_backend_url}/\$\{testC_backend_url\}/g" $package
sed -i $bak "s/${ldap_host}/\$\{testC_ldap_host}/g" $package
rm -rf *.bak

echo "[INFO] Export complete!"
echo ""