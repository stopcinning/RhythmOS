local UserInputService = game:GetService("UserInputService")

local InputManager = {}

InputManager.pressedKeys = {}
InputManager.mousePosition = Vector2.zero

function InputManager:Initialize()
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			self.pressedKeys[input.KeyCode] = true
		end
	end)

	UserInputService.InputEnded:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			self.pressedKeys[input.KeyCode] = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self.mousePosition = input.Position
		end
	end)
end

function InputManager:IsKeyDown(keyCode)
	return self.pressedKeys[keyCode] == true
end

function InputManager:Update(_dt)
	-- future logic can go here
end

return InputManager
