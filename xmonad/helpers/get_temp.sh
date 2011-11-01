#!/bin/bash

sensors | grep "Core $1" | cut -b 16-22

