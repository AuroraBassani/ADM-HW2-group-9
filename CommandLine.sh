#!/bin/sh 
#Download the dataset
wget "https://adm2022.s3.amazonaws.com/instagram_posts.zip"
wget "https://adm2022.s3.amazonaws.com/instagram_profiles.zip"

#Unzip the dataset
unzip instagram_posts.zip
unzip instagram_profiles.zip

#Definite two costant that will be use for   break the loop after 10 posts that satisfy our condition.
a=0
b=1

while  IFS=$'\t' read -r -a myArray; do     #Start the loop, every iteration will be a row of the csv file
h=`echo ${myArray[7]} | wc -m  `;           #Create a variable that contain the length of the description.
if [[ $h  -gt 100 ]];                 #IF statement, if the length is > 100 than 
then 
    echo "${myArray[3]}";             #we print the profile_id and store it in a csv file.
    a=`echo $((a+b))`;
    if [[ $a  -eq 10 ]];         #IF statement, stop the loop after the 10th posts that satisfy our condition.
    then 
        break;
    fi;
fi; 
done < instagram_posts.csv   > ten_profiles.csv    


#instagram_posts.csv  the input dataset
# ten_profiles.csv     the output dataset


while  IFS=$'\t' read -r -a myArray; do        #star the loop, we iterate over ten_profiles.csv, so every iteration will be a profile_id

a=`grep -F -w "${myArray[*]}" "instagram_profiles.csv"`;               #find the correspondent profile in the instagram_profiles.csv dataset by profile_id
len=`echo $a | wc -m  `;                                               #Compute the lenght of the profile

if [[ $len  -eq 1 ]];                                                  #  length  equal to 1 means that the profile_id doesn't exits instagram_profiles.csv dataset,
then
    echo "${myArray[*]}" "User was not found!";                        #so we print "id_profile User was not found!"
fi;
if [[ $len  -gt 1 ]];                                                  # length  greather than 1 means that the profile exits in the instagram_profiles.csv dataset.
then
    echo $a;                                                            # so we print the profile
fi;
done < ten_profiles.csv > solution.csv

# ten_profiles.csv     the input dataset
#solution.csv the output dataset

#Print the results that we get.
more solution.csv