value =[60,100,120];
weight = [10,20,30];
Total = 50;
n = sizeof(value)/sizeof(value[0])

function max()
if a>b
return a
else
return b
end
end

function knapSack(Total,weight,value,n)
if (n == 0 || Total == 0)
return 0
if (weight[n-1]>Total)
return knapSack(Total,weight,value, n-1)
else
return max(value[n-1]+knapSack(Total-weight[n-1],weight,value,n-1),knapSack(Total,weight,value,n-1))
end # if
end
end #function

print(knapSack(Total,weight,value,n))
