#!/bin/bash
source source.properties
folders=( testE )

echo ""
echo "Gateway Migration Utility"
echo "Source: $source_hostname"
echo ""

# Test connection
echo ""
echo "[INFO] Test connection to source gateway..."
echo ""
bash $gmu_path/GatewayMigrationUtility.sh list -t "service" -f "name=Gateway REST Management Service" -h $source_hostname -u admin -x $ADMIN_PASS -trustCertificate  --trustHostname --hideProgress

# Export each folder

# Loop through folders array
for i in "${folders[@]}"
do
output_folder=$i
output_file=$i$ext
output_template=$i$edited$ext
output_config=$i$prop

echo ""
echo "[INFO] Export objects in $output_folder "
echo ""

mkdir ../$output_folder

bash $gmu_path/GatewayMigrationUtility.sh migrateOut -h $source_hostname -u $source_username -x $ADMIN_PASS --trustCertificate  --trustHostname --dest ../$output_folder/$output_file --folderName $output_folder --encryptUsingClusterPassphrase --hideProgress
    
# Create template
echo ""
echo "[INFO] Creating template for $output_folder"
echo ""
cp ../$output_folder/$output_file ../$output_folder/$output_template
bash $gmu_path/GatewayMigrationUtility.sh template --bundle ../$output_folder/$output_template --template ../$output_folder/$output_config --hideProgress

done
    
echo ""
echo "[INFO] Export complete!"
echo ""