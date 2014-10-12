#!/usr/bin/env runhaskell
-- From somewhere on the Pandoc site...
-- includes.hs
import Text.Pandoc.JSON
import System.Directory


doInclude :: Block -> IO Block
doInclude cb@(CodeBlock (id, classes, namevals) contents) = do
  d <- getCurrentDirectory
  case lookup "include" namevals of
       Just f     -> return . (CodeBlock (id, classes, namevals)) =<< readFile (d ++ "/" ++ f)
       Nothing    -> return cb
doInclude x = return x


main :: IO ()
main = toJSONFilter doInclude
