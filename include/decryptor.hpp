#pragma once
#include <string>
#include <nlohmann/json.hpp>

nlohmann::json decryptAndParse(const std::string& jsonData, const std::string& privateKeyPath);
