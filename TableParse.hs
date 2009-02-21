module Main where

import Text.ParserCombinators.Parsec

data Table = Table String [ColumnType] deriving Show

data ColumnType = IntegerColumn String |
                FloatColumn String |
                DateColumn String |
                VarcharColumn String String |
                NumericColumn String String String
                              deriving Show

sample = "CREATE TABLE dude (a int,b float,c date,d varchar(30),e numeric(15,2))"

ident :: Parser String
ident = do c <- letter <|> char '_' 
           cs <- many (alphaNum <|> char '_')
           return (c:cs)
      <?> "identifier"

simpleColParser :: String -> (String -> ColumnType) -> Parser ColumnType
simpleColParser name cstr = do
  colName <- ident
  skipMany1 space
  typ <- string name
  return (cstr colName)
 <?> name

int, float, date, varchar, numeric :: Parser ColumnType
int = simpleColParser "int" IntegerColumn <|> simpleColParser "integer" IntegerColumn

float = simpleColParser "float" FloatColumn

date = simpleColParser "date" DateColumn

varchar = do
  colName <- ident
  skipMany1 space
  typ <- string "varchar"
  char '('
  len <- (many digit)
  char ')'
  return (VarcharColumn colName len)
         <?> "varchar"
         
numeric = do
  colName <- ident
  skipMany1 space
  typ <- string "numeric"
  char '('
  (x:y:ys) <- (many digit) `sepBy` (char ',')
  char ')'
  return (NumericColumn colName x y)
         <?> "numeric"

create :: Parser String
create = string "CREATE TABLE"

column :: Parser ColumnType
column = choice (map try [int, float, date, numeric, varchar])

listSeparator :: Parser ()
listSeparator = do
  skipMany space
  char ','
  skipMany space
  return ()

columnList :: Parser [ColumnType]
columnList = do
  columns <- column `sepBy` listSeparator
  return columns
         <?> "columnList"

createTable :: Parser Table
createTable = do
  create
  skipMany space
  tableName <- ident
  skipMany space
  char '('
  skipMany space
  columns <- columnList
  skipMany space
  char ')'
  return (Table tableName columns)
       <?> "createTable"

main = do
  let test = parse createTable "" sample
  print test
  return ()
