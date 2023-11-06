# Change calculator that displays lowest possible amount of banknotes 
class Purchase():
    def __init__(self, cost, spending):
        self.cost = cost
        self.spending = spending

    def Change(self):
        change = self.spending - self.cost
        print('\nTotal Amount Purchased: US$', "%.2f" % self.cost)
        print('Amount Received: US$', "%.2f" % self.spending) 
        print('Change: US$', "%.2f" % change, end='\n')
        return change     

    def Banknotes(self, cash):
        import math
        BanknotesValue = (100.00, 50.00, 20.00, 10.00, 5.00, 2.00, 1.00, 0.50, 0.25, 0.10, 0.05, 
            0.01)
        # Converts change to paper or coin money as long as it's larger than the last array value
        while cash >= BanknotesValue[-1]:
            for counter in range(len(BanknotesValue)):
                cash = round(cash, 2)  # Prevents bugs with small values
                if BanknotesValue[counter] <= cash:
                    BanknotesAmount = math.floor(cash * 1/BanknotesValue[counter])
                    cash -= (BanknotesValue[counter] * BanknotesAmount)
                    print(BanknotesAmount, 'x', end=' ')
                    # Checks if it's printed money or not
                    if BanknotesValue[counter] > 0.50:
                        print(f"Paper{'s'[:BanknotesAmount^1]}: US$", 
                            "%.2f" % BanknotesValue[counter], end='\n\n')
                    
                    else:
                        print(f"Coin{'s'[:BanknotesAmount^1]}: US$", 
                            "%.2f" % BanknotesValue[counter], end='\n\n')    

def PurchasePrompt():
    while True:
        try:
            price = float(input('Insert product price: US$ '))
            payment = float(input('Insert amount paid by client: US$ '))
         
        except ValueError:
            print('ERROR: PLEASE TYPE A NUMERIC VALUE!\n')
            continue    
        
        else:
            if payment < 0.01 or price < 0.01:
                print('ERROR: IMPOSSIBLE PRICE OR PAYMENT VALUE!')
                continue
            
            elif payment < price:
                print('ERROR: PAYMENT IS NOT ENOUGH TO COMPLETE TRANSACTION!')
                continue
            
        calc = Purchase(price, payment)
        result = calc.Change()
        calc.Banknotes(result)
        break

PurchasePrompt()

while True: 
    choice = input('\nContinue? 1 - Yes/2 - No\n')
    if (choice == '1'):
        PurchasePrompt()
    elif (choice == '2'):
        break        