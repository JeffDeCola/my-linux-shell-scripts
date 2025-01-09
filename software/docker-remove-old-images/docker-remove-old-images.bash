#!/bin/bash -e
# docker-remove-old-images.bash

# Removes old docker images (Keeps one image based on IMAGE ID)

echo " "
echo "************************************************************************"
echo "******************************** docker-remove-old-images.bash (START) *"
echo " "

set -e

# WHAT THIS DOES
echo "This will get rid of any docker images with the same IMAGE ID"
echo " "

# PUT ALL IMAGES IN ARRAY
docker_images=$(docker images --format "{{.ID}}|{{.Repository}}|{{.Tag}}")
echo "Docker Images you have:"
echo "$docker_images"
echo " "

# IMAGE IDS
declare -A image_ids

# READ docker_images LINE BY LINE
while IFS= read -r line
do

    # PUT LINE INTO AN ARRAY
    IFS='|' read -r -a array <<< "$line"
    image_id=${array[0]}
    image_name=${array[1]}
    image_tag=${array[2]}

    echo "LOOKING AT: ${image_name}:${image_tag} (${image_id})"

    if [[ "$image_tag" == "<none>" ]]; then

        echo "REMOVING: ${image_name}:${image_tag} (${image_id})"
        docker rmi "${image_id}"

    # DO WE HAVE THIS "IMAGE ID" IN THE ARRAY?
    elif  [[ -z "${image_ids[$image_name]}" ]]; then

        echo "KEEPING: ${image_name}:${image_tag} (${image_id})"
        # PUT $image_id IN image_ids ARRAY
        image_ids[$image_name]=$image_id

    else

        echo "REMOVING: ${image_name}:${image_tag} (${image_id})"
        docker rmi "${image_name}:${image_tag}"

    fi

    echo " "

done < <(printf '%s\n' "$docker_images")

echo " "
echo "********************************** docker-remove-old-images.bash (END) *"
echo "************************************************************************"
echo " "
