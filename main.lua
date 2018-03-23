-----------------------------------------------------------------------------------------
-- Title: NumericTextFields
-- Name: Your Name
-- Course: ICS2O/3C
-- This program...
-----Change background#####################################
---------------------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Background image with width and height
local backgroundImage = display.newImageRect("Images/background.png", 2048, 1536)

--------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------

-- create local variables
local questionObject
local questionObject2
local questionObject3
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator
local pointsObject
-----countertext---

---------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-- points = points +1
-- pointsobject.text = "points" .. poi

---------------------------------------------------------------------------

local function AskQuestion()
	-- Generate 2 random numbers betweeen a max. and a min. number
	randomNumber1 = math.random(10, 20)
	randomNumber2 = math.random(10, 20)
	randomNumber3 = math.random(10, 20)
	randomOperator = math.random(1, 3)

	if (randomOperator == 1) then
		correctAnswer = randomNumber1 + randomNumber2
		-- Create question in a text object
		questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "="

	elseif (randomOperator == 2) then
		correctAnswer = randomNumber1 * randomNumber2
		questionObject2.text = randomNumber1 .. "*" .. randomNumber2 .. "="
		timer.performWithDelay(1500, HidequestionObject2)

	elseif (randomOperator == 3) then 
		correctAnswer = randomNumber1 - randomNumber2
		questionObject3.text = randomNumber1 .. "-" .. randomNumber2 .. "="
	end
end




local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function Hideincorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end




local function NumericFieldListener( event )

	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- Clear text field
		event.target.text = ""

	elseif event.phase == "submitted" then

		-- When the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)

		-- If the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(1500, HideCorrect)

			elseif (userAnswer ~= correctAnswer) then
				incorrectObject.isVisible = true
				timer.performWithDelay(1500, Hideincorrect)
			end
		
	end
end

---------------------------------------------------------------------------------------
-- OBJECT CREATION
--------------------------------------------------------------------------------------

-- Displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)

-- Displays a question and sets the colour
questionObject2 = display.newText( "", display.contentWidth/2.75, display.contentHeight/2, nil, 110 )
questionObject:setTextColor(155/255, 42/255, 198/255)


-- Create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(50/255, 233/255, 10/255)
correctObject.isVisible = false

-- Create numeric Field
numericField = native.newTextField( display.contentWidth/1.5, display.contentHeight/2, 190, 120 )
numericField.inputType = "number"

-- Add the event listener for the numberic field
numericField:addEventListener( "userInput", NumericFieldListener )

------------

-- Create the correct text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(241/255, 62/255, 62/255)
incorrectObject.isVisible = false


----------------------------------------------------------------------------
-- FUNCTION CALLS
-------------------------------------------------------------------------------

-- Call the function to ask the question
AskQuestion()