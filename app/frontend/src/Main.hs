module Main where

import App

import Shared

import Pure.Magician.Client

main :: IO ()
main = client @MyApp host port MyApp
  where
    host = "127.0.0.1"
    port = 8081
