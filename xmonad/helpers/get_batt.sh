#!/bin/bash

acpi | grep -o -P "[0-9]*%"
