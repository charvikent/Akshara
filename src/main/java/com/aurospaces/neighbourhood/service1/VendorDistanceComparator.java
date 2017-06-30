package com.aurospaces.neighbourhood.service1;
import java.util.Comparator;

import org.springframework.beans.factory.annotation.Autowired;

import com.aurospaces.neighbourhood.db.dao.Vendor1Dao;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;
import com.aurospaces.neighbourhood.db.model.*;


public class VendorDistanceComparator implements Comparator<Vendor1>{
	
	@Autowired Vendor1Dao vendor1Dao;
	
	geotag cust_geo;


	final static double pi = 3.1415;
	final static double earthRadiusKm = 6371.0;


	static double deg2rad(double deg) {
		return (deg * pi / 180);
	}

	// This function converts radians to decimal degrees
	//no problem
	static double rad2deg(double rad) {
		return (rad * 180 / pi);
	}

	static double Distance(geotag g1, geotag g2) {
		double lat1d = g1.x;
		double lon1d = g1.y;
		double lat2d = g2.x;
		double lon2d = g2.y;
		double lat1r, lon1r, lat2r, lon2r, u, v;
		lat1r = deg2rad(lat1d);
		lon1r = deg2rad(lon1d);
		lat2r = deg2rad(lat2d);
		lon2r = deg2rad(lon2d);
		u = Math.sin((lat2r - lat1r) / 2);
		v = Math.sin((lon2r - lon1r) / 2);
		return 2.0
			* earthRadiusKm
			* Math.asin(Math.sqrt(u * u + Math.cos(lat1r) * Math.cos(lat2r)
						* v * v));
	}

	@Override
		public int compare(Vendor1 v1, Vendor1 v2) {
		
		double pref1 = v1.getPreference();
		double pref2 = v2.getPreference();

		/*For ascending order*/
		// return rollno1-rollno2;
		if(pref2>pref1)
			return 1;
		
		//else return -1;
		else if(pref2==pref1)
		{
			


			geotag cust_g=cust_geo;
			cust_g.x=cust_geo.x;
			cust_g.y=cust_geo.y;




//			try {
//				results_v1 = GeocodingApi.geocode(context,
//						v1.location.substring(v1.location.indexOf(",")+1)).await();
//
//
//				String v1loc;
//				v1loc=v1.location.substring(v1.location.indexOf(",")+1);
//				while(results_v1.length==0)
//				{
//
//					results_v1 = GeocodingApi.geocode(context,
//							v1loc.substring(v1loc.indexOf(",")+1)).await();
//					v1loc=v1loc.substring(v1loc.indexOf(",")+1);
//
//				}
//
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
			//if(results.length==0) continue;
			
//			try {
//				results_v2 = GeocodingApi.geocode(context,
//						v2.location.substring(v1.location.indexOf(",")+1)).await();
//
//				String v2loc;
//				v2loc=v2.location.substring(v2.location.indexOf(",")+1);
//				while(results_v2.length==0)
//				{
//
//
//					results_v2 = GeocodingApi.geocode(context,
//							v2loc.substring(v2loc.indexOf(",")+1)).await();
//					v2loc=v2loc.substring(v2loc.indexOf(",")+1);
//
//				}
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
			//if(results.length==0) continue;
			
			geotag vend1_g=new geotag();
			vend1_g.x=v1.getLatitude();
			vend1_g.y=v1.getLongitude();
			
			geotag vend2_g=new geotag();
			vend2_g.x=v2.getLatitude();
			vend2_g.y=v2.getLongitude();

			if(Distance(vend1_g,cust_g)>Distance(vend2_g,cust_g))
				return 1;
			else 
				return -1;
			
		}
		else return -1;
		}
} 
