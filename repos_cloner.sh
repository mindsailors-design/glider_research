#!/bin/bash

# repos=(
# 	"git@bitbucket.org:mindsailors/epd_gui_mockup.git"
# 	"git@bitbucket.org:mindsailors/backlight_server_client.git"
# 	"git@bitbucket.org:mindsailors/it8951_epd_driver.git"
# 	"git@bitbucket.org:mindsailors/it8951e_c_driver.git"
# 	"git@bitbucket.org:mindsailors/epd_mirror_poc.git"
# 	)

REPO_LIST="repos.txt"

# for repo_url in "${repos[@]}"; do
# 	echo "Cloning $repo_url..."
# 	git clone "$repo_url" 
# done

while IFS= read -r repo_url; do 
	[[ -z "$repo_url" || "$repo_url" == \#* ]] && continue
	
	echo "Cloning $repo_url..."
	git clone "$repo_url"
done < "$REPO_LIST"

echo "All repositories cloned!"
