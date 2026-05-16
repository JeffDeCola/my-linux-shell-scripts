#!/bin/bash -e
# docker-remove-old-images.bash

# Removes old docker images (Keeps one image based on IMAGE ID)

echo " "
echo "************************************************************************"
echo "******************************** docker-remove-old-images.bash (START) *"
echo " "

set -e

# PUT ALL IMAGES IN ARRAY -----------------------------------------------------

docker_images=$(docker images --format "{{.ID}}|{{.Repository}}|{{.Tag}}|{{.Size}}")

# PRINT OUT ARRAY OF ALL IMAGES YOU HAVE --------------------------------------

echo "DOCKER IMAGES YOU HAVE:"
echo " "

while IFS= read -r line
do

    # PUT LINE INTO AN ARRAY
    IFS='|' read -r -a array <<< "$line"
    image_id=${array[0]}
    image_name=${array[1]}
    image_tag=${array[2]}
    image_size=${array[3]}

    echo "    ${image_name}:${image_tag} (${image_id}) - ${image_size}"

done < <(printf '%s\n' "$docker_images")

echo " "

# READ docker_images LINE BY LINE ---------------------------------------------

# IMAGE IDS
declare -A image_ids

# SUMMARY
declare -a kept_images
ki=0
declare -a removed_dangling_images
rdi=0
declare -a removed_old_images
roi=0
declare -a failed_to_remove_images
ftri=0

while IFS= read -r line
do

    # PUT LINE INTO AN ARRAY
    IFS='|' read -r -a array <<< "$line"
    image_id=${array[0]}
    image_name=${array[1]}
    image_tag=${array[2]}
    image_size=${array[3]}

    echo "---------------------------------------------------------------------"
    echo "LOOKING AT: ${image_name}:${image_tag} (${image_id}) - ${image_size}"
    echo " "

    # IF IMAGE TAG IS "<none>" THEN REMOVE IT - THIS IS A DANGLING IMAGE
    if [[ "$image_tag" == "<none>" ]]; then

        if ! docker rmi "${image_id}"; then
            # If the command failed, print an error message
            tput setaf 1; echo "    ERROR: Failed to remove dangling image ${image_name}:${image_tag} (${image_id}) - ${image_size}"; tput sgr0
            failed_to_remove_images[ftri]="${image_name}:${image_tag} (${image_id}) - ${image_size}"
            ftri=$((ftri+1))
        else
            tput setaf 1; echo "    REMOVED DANGLING IMAGE: ${image_name}:${image_tag} (${image_id}) - ${image_size}"; tput sgr0
            removed_dangling_images[rdi]="${image_name}:${image_tag} (${image_id}) - ${image_size}"
            rdi=$((rdi+1))
        fi

    # DO WE HAVE THIS "IMAGE ID" IN THE ARRAY?
    elif  [[ -z "${image_ids[$image_name]}" ]]; then

        # We don't have this image in array, so keep it
        tput setaf 2; echo "    KEEPING IMAGE: ${image_name}:${image_tag} (${image_id}) - ${image_size}"; tput sgr0
        # PUT $image_id IN image_ids ARRAY
        image_ids[$image_name]=$image_id
        kept_images[ki]="${image_name}:${image_tag} (${image_id}) - ${image_size}"
        ki=$((ki+1))

    else

        # Already have this image in array, so remove it
        if ! docker rmi "${image_name}:${image_tag}"; then
            # If the command failed, print an error message
            tput setaf 1; echo "    ERROR: Failed to remove older image ${image_name}:${image_tag} (${image_id}) - ${image_size}"; tput sgr0
            failed_to_remove_images[ftri]="${image_name}:${image_tag} (${image_id}) - ${image_size}"
            ftri=$((ftri+1))
        else
            tput setaf 1; echo "    REMOVED OLDER IMAGE: ${image_name}:${image_tag} (${image_id}) - ${image_size}"; tput sgr0
            removed_old_images[roi]="${image_name}:${image_tag} (${image_id}) - ${image_size}"
            roi=$((roi+1))
        fi

    fi

    echo " "

done < <(printf '%s\n' "$docker_images")

# SUMMARY ---------------------------------------------------------------------

echo "---------------------------------------------------------------------"
echo " "

echo "KEPT IMAGES:"
for i in "${kept_images[@]}"
do
    tput setaf 2; echo "    $i"; tput sgr0
done
echo " "

echo "REMOVED DANGLING IMAGES:"
for i in "${removed_dangling_images[@]}"
do
    tput setaf 1; echo "    $i"; tput sgr0
done
echo " "

echo "REMOVED OLD IMAGES:"
for i in "${removed_old_images[@]}"
do
    tput setaf 1; echo "    $i"; tput sgr0
done
echo " "

echo "FAILED TO REMOVE IMAGES:"
for i in "${failed_to_remove_images[@]}"
do
    tput setaf 1; echo "    $i"; tput sgr0
done

echo " "
echo "********************************** docker-remove-old-images.bash (END) *"
echo "************************************************************************"
echo " "
