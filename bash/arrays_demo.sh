
echo ===== initialize =====

myarr=( {0..2} "hello world" 4 )

echo ${myarr[@]}

echo ===== length =====

len=${#myarr[@]}

echo $len

echo ===== for loop =====

for (( i=0; i<$len; i++ ))
do
    echo "$i ${myarr[$i]}"
done

echo ===== foreach =====

for item in "${myarr[@]}"
do
    echo "$item"
done

echo ===== keys =====

key=( ${!myarr[@]} )

echo ${key[@]}

echo ===== values =====

val=( "${myarr[@]}" )

echo ${val[@]}

echo ===== append =====

myarr+=( "test test" )

echo ${myarr[@]}

echo ===== prepend =====

myarr=( yaaa "${myarr[@]}" )

echo ${myarr[@]}

echo ===== shift =====

myarr=( "${myarr[@]:1}" )

echo ${myarr[@]}

echo ===== pop =====

myarr=( "${myarr[@]:0:${#myarr[@]}-1}" )

echo ${myarr[@]}

echo ===== insert =====

myarr=( "${myarr[@]:0:2}" "new element" "${myarr[@]:2}" )

echo ${myarr[@]}

echo ===== remove =====

myarr=( "${myarr[@]:0:4}" "${myarr[@]:5}" )

echo ${myarr[@]}


