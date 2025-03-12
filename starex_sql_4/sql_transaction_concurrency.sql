-- Transaction & Concurrency - ACID properties
-- Transaction - When working with the database, 
	-- transaction ensures multiple operations happens together safely
-- Concurrency referes to multiple users accessing 
	-- the database at the same time without causing errors
    
-- A transaction is a group of sql operations that must be executed together.
-- if any steps fails, the entire transaction is rolledback(cancelled) ensuring 
	-- database reamin in correct state
-- Example- transferring money between ban accounts
	-- Suppose 500 to be transferred from 'Account A' to 'Account B'
    -- The transaction contains two steps
		-- deduct 500 from 'Account A'
        -- deposit 500 in 'Account B'
	-- If the money is deducted from 'Account A' but not deposited to 'Account B'
		-- because of any error or crash, the must be cancelled to avoid loss of 500.
        
        
-- ACID properties of DBMS ensures database transaction are safe and reliable
-- A(ATomicity) - All or nothing, either the whole transaction will happen or nothing happen
	-- If the money is deducted from Account A, but not added to account B, the transaction is cancelled
-- C(Consistency) - The database remains in correct before and after the transaction
	-- After transferring money, the total balance A+B should remain same
-- I(Isolation) - Transaction run independently without interfering with each other
	-- If two people are transferring money at same time, their transaction don't mix up 
-- D(Durability) - Once a transaction is completed, the changes are saved permanently, even if there is power failure
	-- If the amount is transferred, it is permanently updated in the bank's database