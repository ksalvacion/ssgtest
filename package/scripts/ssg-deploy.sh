#!/bin/bash
source target.properties

echo ""
echo "Gateway Migration Tool"
echo "Target: $dest_hostname"
echo ""

# Test connection
echo ""
echo "[INFO] Testing connection to $dest_hostname"
echo ""
bash $gmu_path/GatewayMigrationUtility.sh list -t "service" -f "name=Gateway REST Management Service" -h $dest_hostname -u admin -x $ADMIN_PASS -trustCertificate --trustHostname --hideProgress

# Loop through folders array
for i in "${target_folders[@]}"
do
target_folder=$i
bundle_file=$i$edited$ext
bundle_config=$i$prop

echo ""
echo "Migrate $target_folder to gateway:"
echo ""

# For initial deployment
bash $gmu_path/GatewayMigrationUtility.sh migrateIn -h $dest_hostname -u $dest_username -x $ADMIN_PASS --trustCertificate --trustHostname --bundle ../$target_folder/$bundle_file --template ../$target_folder/$bundle_config --results results.xml

echo ""
echo "[INFO] Update policy mappings"
echo ""

# For deploying updates
#bash $gmu_path/GatewayMigrationUtility.sh manageMappings --bundle ../$target_folder/$bundle_file --outputFile ../$target_folder/override-mappings.xml --type policy --action Update

echo ""
echo "[INFO] Update service mappings"
echo ""

#bash $gmu_path/GatewayMigrationUtility.sh manageMappings --bundle ../$target_folder/$bundle_file --outputFile ../$target_folder/override-mappings.xml --type services --action Update

echo ""
echo "[INFO] Importing files"
echo ""

#bash $gmu_path/GatewayMigrationUtility.sh migrateIn -h $dest_hostname -u $dest_username -x $ADMIN_PASS --trustCertificate --trustHostname --bundle ../$target_folder/$bundle_file --template ../$target_folder/$bundle_config --map ../$target_folder/override-mappings.xml --results results.xml

done