using Printf

#Question 1: Hill climbing

#a structure that holds weight,values and number of items
struct k{T<:Real}
    weight::T
    value::T
    nvalue::T
end

#making sure weight and values are of the same type and getting value per weight
function k(weight::Real,value::Real)
    w,v = promote(weight, value)
    wt = v./w
    k(w,v,wt)
end

#printing and formating the output
Base.show(io::IO,s::k) = print(io,@sprintf "[ %.2f kg, %.2f N, %.2f N/kg ]" s.weight s.value s.nvalue)

#checking for the smallest value between current and neighbor
Base.isless(current::k,neighbor::k) = current.nvalue < neighbor.nvalue

#the hill climbing function
function hill_climbing(items::Vector{k{T}},limit::Real) where T<:Real
    knapSack = similar(items,0)
    wt = zero(T)

    #exploring items in a vector
    for i in sort(items,rev = true)
        if wt + i.weight <= limit
            wt += i.weight
            push!(knapSack,i)
        else
            w = limit - wt
            v = w*i.nvalue
            push!(knapSack,k(w,v,i.value))
            break
        end
    end
    #returning the knapsack
    return knapSack
end

n = 10
items = [k(38//10, 36), k(54//10, 43),k(36//10, 90),k(24//10, 45),k(4//1, 30),k(25//10, 56),k(37//10, 67),k(3//1, 95)]

sack = hill_climbing(items,n)
println("\nAvailable items: \n  ", join(items, "\n  "))
println("\nItems in the solution:\n ", join(sack, "\n "))
@printf("\nTotal value: %.2f \n", sum(getfield.(sack, :value)))



#Question 2: Minimax
mini,maxi = 1000, -1000

function minimax(depth,node,maxiPlayer,v,alpha,beta)
    if depth == 3
        return v[node]
    end
    #maximum player
    if maxiPlayer
        best = mini
        #exploring the left and right children
        for i in 1:3
            val = minimax(depth+1,node * 2 + i,false,v,alpha,beta)
            best = max(best,val)
            alpha = max(alpha,best)

            #pruning the node
            if beta <= alpha
                break
            end
        end
        return best

    #minimum player
    else
        best = maxi
        #exploring the left and
        for i in 1:3
            val = minimax(depth+1,node * 2 + i,true,v,alpha,beta)
            best = min(best,val)
            beta = min(beta,best)

            #pruning the currentNode
            if beta <= alpha
                break
            end
        end
        return best
    end
end # function

v = [4,8,6,9,1,2,5,7]
println("Optimal value is: ",minimax(0,0,true,v,mini,maxi))

