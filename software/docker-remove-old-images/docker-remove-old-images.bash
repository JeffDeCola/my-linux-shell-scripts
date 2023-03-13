#!/bin/bash -e
# docker-remove-old-images.bash

echo " "
echo "************************************************************************"
echo "******************************** docker-remove-old-images.bash (START) *"
echo " "

set -e

# PUT ALL IMAGES IN ARRAY
docker_images=$(docker images --format "{{.ID}}|{{.Repository}}|{{.Tag}}")
echo "Docker Images you have:"
echo "$docker_images"
echo " "

# IMAGE NAME LOOKUP
declare -A image_names

# READ docker_images LINE BY LINE
while IFS= read -r line
do
    
    # PUT LINE INTO AN ARRAY
    IFS='|' read -r -a array <<< "$line"
    image_id=${array[0]}
    image_name=${array[1]}
    image_tag=${array[2]}
    
    echo "WROKIGN ON: ${image_name}:${image_tag} (${image_id})"

    # DO WE HAVE THIS IMAGE NAME IN THE ARRAY?
    if [[ -z "${image_names[$image_name]}" ]]; then
    
        # NOPE: KEEP IT
        echo "KEEPING: ${image_name}:${image_tag}"
        image_names[$image_name]=$image_id
    
   else
    
        # ALREADY GOT IT
        echo "REMOVING: ${image_name}:${image_tag}"
        # docker rmi "${image_name}:${image_tag}" ???????????????????????????????????

    fi

    echo " "

done < <(printf '%s\n' "$docker_images")

echo "********************************** docker-remove-old-images.bash (END) *"
echo "************************************************************************"
echo " "
