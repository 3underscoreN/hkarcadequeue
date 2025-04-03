/*
 * hkarcadequeue - An app for providing HK arcade info.
 * Copyright (C) 2025 CHAN Chung Yuk
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

const Map<String, int> possibleCrowdness = {
    "zero": 0,
    "low": 1,
    "medium": 2,
    "high": 3,
    "dontgo": 4,
};

const Map<int, String> crowdnessChinese = {
    0: "無人排隊",
    1: "1-4人排隊",
    2: "5-8人排隊",
    3: "9-12人排隊",
    4: "人山人海",
};