### Basic math operations

4 + 5 #Addition

3^4 #Exponent

91 / 2 #Division

### Vector operations

A = [10, 20, 30] #Create a row vector. 

A[1] #Access first element. Julia is 1-indexed

A = [10; 20; 30] #Create a column vector. Semi-colon is used to change row.

A[1] = 199 #Change a value at index 1.
#A

### Matrix operations

M = [1 2 3; 4 5 6; 7 8 9] #Semi-colon is used to change rows.
#Space is used to seperate columns.

M[1, 2] = 3663 #Accessing element of 1st row and 2nd column.
#M

M' #Transpose of a matrix can be calculated using single qoute after the matrix name.

inv(M) #Inverse of a matrix.

### Dictionary

D = Dict("name" => "Analytics Vidhya", "Year" => 2017) #Create a Dictionary.

D["Year"] #Access elements using keys.

D.count #Number of elements in the dictionary.

### Strings

text = "Some String"     #Create a new string
println(text[1])         #Access character at index 1
println(text.len)        #Length of string

text[2:7]                #Extract the string from index 2 to 7.

# Strings are immutable(cannnot be changed once created)

text[1] = "H"           #Should give an error

### Loops

for item in "String"   #for loop
    println(item)
end



i = 0
while i <= N            #while loop
    println(i)
    i += 1
end


fact = 1
for i in range(1, 5)
    fact = fact * i
end
print(fact)


### if-else conditional

N = 6
if N >= 0
    print("N is positive")
else
    print("N is negative")
end

