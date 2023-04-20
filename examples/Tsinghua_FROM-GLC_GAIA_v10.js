var dataset = ee.Image("Tsinghua/FROM-GLC/GAIA/v10");

var visualization = {
  bands: ['change_year_index'],
  min: 0.0,
  max: 34.0,
  palette: [
    "014352","1A492C","071EC4","B5CA36","729EAC","8EA5DE",
    "818991","62A3C3","CCF4FE","74F0B9","32BC55","C72144",
    "56613B","C14683","C31C25","5F6253","11BF85","A61B26",
    "99FBC5","188AAA","C2D7F1","B7D9D8","856F96","109C6B",
    "2DE3F4","9A777D","151796","C033D8","510037","640C21",
    "31A191","223AB0","B692AC","2DE3F4",
  ]
};

Map.setCenter(-37.62, 25.8, 2);

Map.addLayer(dataset, visualization, "Change year index");