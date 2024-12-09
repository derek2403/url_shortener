# URL Shortener

A simple URL shortener service built with Ruby on Rails that allows users to create shortened URLs and track their usage statistics.

## Features

- Create shortened URLs from long URLs
- Track visit statistics including:
  - Number of clicks
  - Visit timestamps
  - Visitor locations (based on IP)
  - Visitor IP addresses
- View all shortened URLs in a list
- Automatic title extraction from target URLs

## Technical Details

- Built with Ruby on Rails 7.1
- Uses JSON files for data storage (no database required)
- Minimal styling with pure CSS
- Geocoding for visitor location detection

## Requirements

- Ruby 3.2.2
- Rails 7.1.0
- Node.js (for asset compilation)

## Installation

1. Clone the repository:
