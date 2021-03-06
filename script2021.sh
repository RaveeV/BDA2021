echo ${YEAR:=2021}

#download data from the data source
gsutil -m cp -r gs://bda12021/bts/$YEAR/*csv . 

#There is no need to unzip these file as it is already in csv file
#unzip zip file to csv file with respective name
#for month in `seq -w 1 12`; do 
#   unzip $YEAR$month.zip
#   mv *ONTIME.csv $YEAR$month.csv
#   rm $YEAR$month.zip
#done


#removing the quotation mark from csv file
for month in `seq -w 1 12`; do
    echo $YEAR$month.csv
    sed 's/,$//g' $YEAR$month.csv | sed 's/"//g' > tmp
    mv tmp $YEAR$month.csv
done

#uploading all csv file to the bucket
gsutil -m cp -r ./$YEAR*csv gs://bda2021_pj1/bts

#remove the zip file
rm $YEAR*csv

#Displaying complete message
echo Script2021 Completed