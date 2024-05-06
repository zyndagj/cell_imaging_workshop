from sklearn.preprocessing import LabelEncoder
LE = LabelEncoder()

df1 = gpd.GeoDataFrame({'area' : df_slide.area, 'length' : df_slide.length, "cell_type" : df_slide["cell_type"]})
df1['cell_type_num'] = LE.fit_transform(df1['cell_type'])
df1
    
