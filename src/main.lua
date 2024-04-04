-- Consts
WINDOW_W = 800
WINDOW_H = 600

local transf = {}

function matProd(pM1, pM2)
  -- you can multiply matrices only if
  -- the number of columns of the first matrix
  -- equal the number of lines of the second one
  -- print('Dans matProd')
   -- print(pM1, pM2)
    if #pM1[1] ~= #pM2 then      
        return nil      
    end 

    local result = {}
    
    for l1 = 1, #pM1 do
        result[l1] = {}
        for c2 = 1, #pM2[1] do
            result[l1][c2] = 0
            for l2 = 1, #pM2 do
                result[l1][c2] = result[l1][c2] + pM1[l1][l2] * pM2[l2][c2]
            end
        end
    end

    return result
end


-- identity function (no transform)
transf.id = function(pCoord)
 -- useless function but shows that
 -- |1 0 0|
 -- |0 1 0| matrix
 -- |0 0 1|
 -- x_transf = x * 1 + y * O + 1 * 0 = x
 -- y_transf = x * 0 + y * 1 + 1 * 0 = y
 -- third term = x * 0 + y * 0 + 1 * 1 = 1
  local identity = {{1, 0, 0},
                    {0, 1, 0},
                    {0, 0, 1}}

  return matProd({pCoord}, identity)[1]

end


transf.hflip = function(pCoord)
  -- |-1 0 0|
  -- | 0 1 0| matrix
  -- | 0 0 1|
  -- x_transf = x * -1 + y * 0 + 1 * 0 = -x
  -- y_transf = x * 0 + y * 1 + 1 * 0 = y
  -- third term = x * 0 + y * 0 + 1 * 1 = 1

  local hFlip = {{-1, 0, 0},
                 {0, 1, 0},
                 {0, 0, 1}}
  
  return matProd({pCoord}, hFlip)[1]

end


transf.vflip = function(pCoord)
  -- |1  0  0|
  -- |0 -1  0| matrix
  -- |0  0  1|
  -- x_transf = x * 1 + y * 0 + 1 * 0 = x
  -- y_transf = x * 0 + y * -1 + 1 * 0 = -y
  -- third term = x * 0 + y * 0 + 1 * 1 = 1
  local vFlip = {{1, 0, 0},
                 {0, -1, 0},
                 {0, 0, 1}}

  return matProd({pCoord}, vFlip)[1]

end


transf.rot = function(pCoord)
  -- rotation matrix, clockwise
  -- |cos(angle)  -sin(angle) 0|
  -- |sin(angle)   cos(angle) 0|
  -- |0             0         1|
  -- x_transf = x * cos(angle) + y * sin(angle) + 1 * 0
  -- y_transf = -sin(angle) * x + y * cos(angle) + 1 * 0 
  -- third term = x * 0 + y * 0 + 1 * 1 = 1
  local radAngle = math.rad(10)
  local rotation = {{math.cos(radAngle), math.sin(radAngle), 0},
              {-math.sin(radAngle), math.cos(radAngle), 0},
              { 0, 0, 1}}

  return matProd({pCoord}, rotation)[1]

end


transf.c_rot = function(pCoord)
  -- rotation matrix, counter-clockwise
  -- |cos(angle)   sin(angle) 0|
  -- |-sin(angle)  cos(angle) 0|
  -- |0             0         1|
  -- x_transf = x * cos(angle) - sin(angle) * y + 1 * 0
  -- y_transf = x * sin(angle) + cos(angle) + y + 1 * 0
  -- third term = x * 0 + y * 0 + 1 * 1 = 1
  local radAngle = math.rad(10)
  local rotation_counter = {{math.cos(radAngle), -math.sin(radAngle), 0},
                            {math.sin(radAngle), math.cos(radAngle), 0},
                            { 0, 0, 1}}

  return matProd({pCoord}, rotation_counter)[1]

end


  -- scaling matrix
  -- | Sx O  0|
  -- | 0  Sy 0|
  -- | 0  0  1|
  -- x_transf = x * Sx + y * 0 + 1 * 0 = x * Sx
  -- y_transf = x * 0 + y * Sy + 1 * 0 = y * sY
  -- third term = x * 0 + y * 0 + 1 * 1 = 1
  transf.upscaleX = function(pCoord)

  local scaling = {{1.1, 0, 0},
                   {0, 1, 0},
                   {0, 0, 1}}

  return matProd({pCoord}, scaling)[1] 

end
 

transf.downscaleX = function(pCoord)

  local scaling = {{.9, 0, 0},
                   {0, 1, 0},
                   {0, 0, 1}}

  return matProd({pCoord}, scaling)[1] 

end


transf.upscaleY = function(pCoord)

  local scaling = {{1, 0, 0},
                   {0, 1.1, 0},
                   {0, 0, 1}}

  return matProd({pCoord}, scaling)[1] 

end
 

transf.downscaleY = function(pCoord)

  local scaling = {{1, 0, 0},
                   {0, .9, 0},
                   {0, 0, 1}}

  return matProd({pCoord}, scaling)[1]

end


transf.tearX = function(pCoord)
-- tearing x matrix
-- |1 S 0|
-- |0 1 0|
-- |0 0 0|
-- x_transf = x * 1 + y * S + 1 * 0 = x + y*S
-- y_transf = x * 0 + y + 1 + 1 * 0 = y
-- third term = x * 0 + y * 0 + 1 * 1 = 1
  local tearing = {{1, 0.1, 0},
                   {0, 1, 0},
                   { 0, 0, 1}}

  return matProd({pCoord}, tearing)[1] 

end


transf.tearY = function(pCoord)
-- tearing y matrix
-- |1 O 0|
-- |S 1 0|
-- |0 0 1|
-- x_transf = x * 1 + y * 0 + 1 * 0 = x 
-- y_transf = x * S + y + 1 + 1 * 0 = y + x * S
-- third term = x * 0 + y * 0 + 1 * 1 = 1

  local tearingY = {{1, 0, 0},
                   {0.1, 1, 0},
                   {0, 0, 1}}

  return matProd({pCoord}, tearingY)[1] 

end


  -- translation matrix
  -- |1  0  0|
  -- |0  1  0|
  -- |Tx Ty 1|
  -- x_transf = x * 1 + y * 0 + 1 * Tx = x + Tx
  -- y_transf = x * 0 + y * 1 + 1 * TY = y + Ty
  -- third term = x * 0 + y + 0 + 1 + 1 = 1
transf.translate_to_origin = function(pCoord)

  local translate = {{1, 0, 0},
                     {0, 1, 0},
                     {-120 , -140 , 1}}
  
  return matProd({pCoord}, translate)[1]

end


transf.translate_from_origin = function(pCoord)

    local translate = {{1, 0, 0},
                       {0, 1, 0},
                       {120 , 140 , 1}}
    
    return matProd({pCoord}, translate)[1]

end


function love.load()

  love.window.setMode(WINDOW_W, WINDOW_H)
  love.window.setTitle('2x2 matrices 2D transformations demo')

  showHelp = true 
  auth = false
  pointsLst = {{100, 100, 1},
               {140, 100, 1},
               {140, 180, 1},
               {100, 180, 1},
               {100, 160, 1},
               {120, 140, 1},
               {100, 120, 1},
               {100, 100, 1}
          }

end


function love.update(dt)

  if auth == true then

    for i, point in ipairs(pointsLst) do
      point = transf.translate_to_origin(point)
      point = transf[transformation](point)
      pointsLst[i] = transf.translate_from_origin(point)
    end
    auth = false

  end     
  
end


function love.draw()

  local originX = WINDOW_W/2
  local originY = WINDOW_H/2

  -- draw axes
  love.graphics.setColor(1,0,0)
  love.graphics.line(0, originY, WINDOW_W, originY)
  love.graphics.line(originX, 0, originX, WINDOW_H)
  love.graphics.setColor(1, 1, 1)

  -- draw figure
  for idx=1, #pointsLst-1 do
    love.graphics.line(
                        pointsLst[idx][1] + originX, 
                        pointsLst[idx][2] + originY, 
                        pointsLst[idx+1][1] + originX, 
                        pointsLst[idx+1][2] + originY
                        ) 
  end


  if showHelp == true then
    love.graphics.print('‘i’ for identity', 10, 20)
    love.graphics.print('’h’ for horizontal flip', 10, 40)
    love.graphics.print('’v’ for vertical flip', 10, 60)
    love.graphics.print('’r’ for rotation, 10° pace', 10, 80)
    love.graphics.print('’c’ for counter-rotation, 10° pace', 10, 100)
    love.graphics.print('’x/y and +/-’ for scaling x or y ±10%', 10, 120)
    love.graphics.print('’x/y and t’ for x/y sort of tearing/shearing, factor .1', 10, 140)
    love.graphics.print('’space’ to hide/show instructions', 10, 160)
  end

end


function love.keypressed(key)

  if key == 'escape' then
    love.event.quit()
  end

  if key == 'r' then
    transformation = 'rot'
    auth = true
  end

  if key == 'i' then
    transformation = 'id'
    auth = true
  end

  if key == 'h' then
    transformation = 'hflip'
    auth = true
  end

  if key == 'v' then
    transformation = 'vflip'
    auth = true
  end

  if key == 'c' then
    transformation = 'c_rot'
    auth = true
  end

  if (key == 'x' and love.keyboard.isDown('+')) or (key == '+' and love.keyboard.isDown('x')) then
    transformation = 'upscaleX'
    auth = true
  end

  if (key == 'x' and love.keyboard.isDown('-')) or (key == '-' and love.keyboard.isDown('x')) then
    transformation = 'downscaleX'
    auth = true
  end

  if (key == 'y' and love.keyboard.isDown('+')) or (key == '+' and love.keyboard.isDown('y')) then
    transformation = 'upscaleY'
    auth = true
  end

  if (key == 'y' and love.keyboard.isDown('-')) or (key == '-' and love.keyboard.isDown('y')) then
    transformation = 'downscaleY'
    auth = true
  end

  if (key == 'x' and love.keyboard.isDown('t')) or (key == 't' and love.keyboard.isDown('x')) then
    transformation = 'tearX'
    auth = true
  end

  if (key == 'y' and love.keyboard.isDown('t')) or (key == 't' and love.keyboard.isDown('y')) then
    transformation = 'tearY'
    auth = true
  end

  if key == 'space' then
    showHelp = not showHelp
  end

end
