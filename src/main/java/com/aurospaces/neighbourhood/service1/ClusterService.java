package com.aurospaces.neighbourhood.service1;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import com.aurospaces.neighbourhood.db.model.*;
import com.aurospaces.neighbourhood.db.dao.*;
import com.aurospaces.neighbourhood.patent.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.aurospaces.neighbourhood.custommodel.VendorLocation;


@Repository(value = "clusterService")
public class ClusterService
{

@Autowired Vendor1Dao vendor1Dao;
@Autowired Cluster1Dao cluster1Dao;
@Autowired Service1Dao service1Dao;
@Autowired VendorService1Dao vendorservice1Dao;


static int diameter = 0;
final static double pi = 3.1415;
final static double earthRadiusKm = 6371.0;
final static int UNITSIZE = 50;
final static int CLUSTERSIZE = 10;

	private static final double MIN_LAT = Math.toRadians(-90d);  // -PI/2
	private static final double MAX_LAT = Math.toRadians(90d);   //  PI/2
	private static final double MIN_LON = Math.toRadians(-180d); // -PI
	private static final double MAX_LON = Math.toRadians(180d);  //  PI


//no problem
public static int randInt(int min, int max) {

	Random rand = new Random();
	int randomNum = rand.nextInt((max - min) + 1) + min;
	return randomNum;
}


/* todo REMOVE hardcoding */
public int getLocationId(double latitude, double longitude)
{
	return 24; // Bengaluru  hardcoded
}
public int getLocationId(String latitude, String longitude)
{
	return 24; // Bengaluru  hardcoded
}



// decimal degrees to radians
//no problem
static double deg2rad(double deg) {
	return (deg * pi / 180);
}

// This function converts radians to decimal degrees
//no problem
static double rad2deg(double rad) {
	return (rad * 180 / pi);
}

// Using Haversine_formula
//no problem
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


private ArrayList<cluster> find_radius(ArrayList<cluster> clusters) {
	// TODO Auto-generated method stub
	
	for (int i = 0; i < clusters.size(); i++) {
		Iterator<Vendor1> it = clusters.get(i).members.iterator();
        double min=1;
        geotag g=new geotag();
        g.x=clusters.get(i).center_x;
        g.y=clusters.get(i).center_y;
        
		while (it.hasNext())
		{
			Vendor1 temp = it.next();
		    geotag temp_g=new geotag();
		    temp_g.x=(temp.getLatitude());
		    temp_g.y=(temp.getLongitude());
			if(Distance(temp_g,g)>min)
				min=Distance(temp_g,g);
		}
		clusters.get(i).radius=min;
	}
	
	return clusters;
}


/** Get te list of cu */
public  ArrayList<cluster> createClusters(List<Vendor1> vend1,int k,int k_new)
{
	
	
	int asz = vend1.size();
	boolean[] visited = new boolean[vend1.size()];
	boolean change = false;

	 //no units visited so far
	for (int i = 0; i < asz; i++)
		visited[i] = false;

	double average = 0;
   
	//calculating average of the whole 
	for (int i = 0; i < asz; i++) {
		visited[i] = false;
		average += (vend1.get(i).getWeightage());
	}

	average = average / k;

	ArrayList<cluster> clusters = new ArrayList<cluster>();// space for
															// childs

	// sort here
   
	//random center intialization - fixing k random centres choosing among units
	for (int i = 0; i < k; i++) {
		int random = randInt(0, asz - 1);
		clusters.add(new cluster());
		clusters.get(i).center_x = (vend1.get(random).getLatitude());
		clusters.get(i).center_y = (vend1.get(random).getLongitude());
	}

	int count = 1;
	int dynamic_bound = 1000;
	int visited_count = 0;
	int loops = 0;

	
	//now looping for 1000 times
	do {

		visited_count = 0;
		count = 1;
      //as bound on the closest distance being diamter
		while (count < diameter)// use diameter
		{
            //adding close ones to each cluster
			for (int i = 0; i < k; i++) 
			{
				int sum = 0;
				//see which among the units can be assigned to each cluster in order
				// and in increasing counts.
				//not assigning here but seeing the total sum if it was assigned
				for (int j = 0; j < asz; j++) 
				  {
					if (visited[j])
						continue;
					if ((vend1.get(j).getLatitude()) < clusters.get(i).center_x + count
							&& (vend1.get(j).getLongitude()) < clusters.get(i).center_y
									+ count) 
					{
						sum += (vend1.get(j).getWeightage());
					}

				   }
				//here one cluster taken in order and see if sum of the possible in it
				// is less than 1.2 * average
                //now actually add to all clusters
				if (clusters.get(i).weightage + sum <= 1.2 * average) 
				{

					for (int j = 0; j < asz - 1; j++)// improve by sorting
														// the points
					 {
						if (visited[j])
							continue;
						if (((vend1.get(j).getLatitude()) < (clusters.get(i).center_x + count))
								&& ((vend1.get(j).getLongitude()) < (clusters.get(i).center_y + count))) 
						  {
							visited[j] = true;
							visited_count++;
							// update cluster fields..after inclusion of the
							// new point
							clusters.get(i).members.add(vend1.get(j));
					//		clusters.get(i).weightage += vend1.get(j).getWeightage();
							clusters.get(i).sumx += (vend1.get(j).getLatitude());
							clusters.get(i).sumy += (vend1.get(j).getLongitude());
							clusters.get(i).size += 1; //
						//	clusters.get(i).radius=count;
						  }

					 }

				}// if
			}//added to all clusters till here

			count++;
		}// end of while
		//NOTE till here all points are assigned to one of the random centres chosen intially and
		// the diameter of the cluster has increased throughout till earth diamter

		
		
		
		
		// cout<<"visited before fixing: "<<visited_count<<endl;
		
		
      //calculating min distance for each business point
	//and adding each business point to nearest cluster centre
		for (int j = 0; j < asz; j++) 
		{
			if (visited[j] == true)
				continue;
			double min = 1000000;
			int min_index = 0;
			for (int i = 0; i < k; i++) 
			{
				geotag tempgeo = new geotag();
				tempgeo.x = clusters.get(i).center_x;
				tempgeo.y = clusters.get(i).center_y;
				geotag vend_geo=new geotag();
				vend_geo.x=(vend1.get(j).getLatitude());
				vend_geo.y=(vend1.get(j).getLongitude());
				double x = Distance(vend_geo, tempgeo);
				if (x < min) 
				{
					min = x;
					min_index = i;
				}
			}
			visited[j] = true;
			visited_count++;
			
			//add each units to the nearest centre of the different clusters
			clusters.get(min_index).add(vend1.get(j));
		//	clusters.get(min_index).weightage += (vend1.get(j).weightage);
			clusters.get(min_index).sumx += (vend1.get(j).getLatitude());
			clusters.get(min_index).sumy += (vend1.get(j).getLongitude());
			clusters.get(min_index).size += 1; //
		}

		//now on adding the other units to each cluster,the weight may exceed
		for (int i = 0; i < k; i++) 
		{
           //seeing if the cluster weight exceeds
			if (clusters.get(i).weightage > 1.5 * average) 
			{
				ArrayList<Vendor1> a_new = new ArrayList<Vendor1>();
				Iterator<Vendor1> it = clusters.get(i).members.iterator();

				while (it.hasNext()) 
				{
				//	unit u = new unit();
					Vendor1 temp = it.next();
				//	u.g.x = temp.g.x;
			//		u.g.y = temp.g.y;
				//	u.weightage = temp.weightage;
					a_new.add(temp);
				}

				Integer knew1 = 0;
				ArrayList<cluster> child_clusters;
				//find child cluster for weight exceeded ones
				child_clusters = createClusters(a_new, 2, knew1);// check
                //just add the basic cluster - the intial child
				if (knew1.intValue() > 1) {
					clusters.add(i, child_clusters.get(0));
				}
				//add other children clusters at end
				for (int j = 1; j < knew1; j++) {
					clusters.add(k, child_clusters.get(j));
					k++;
				}
			}

		}

		change = false;

		double centroid_x;
		double centroid_y;

		/*
		 * for(int i=0;i<CLUSTERSIZE;i++) {
		 * cout<<clusters[i].weightage<<endl; }
		 */
		
         //seeing if a cluster centre as changed after assigning to nearest random centres
		//set change to true
		for (int i = 0; i < k; i++) 
		{
			centroid_x = clusters.get(i).sumx/ (double) clusters.get(i).size;
			centroid_y = clusters.get(i).sumy/ (double) clusters.get(i).size;
			//see if centre of cluster has changed and set change to true
			if ((int) (Math.abs(centroid_x - clusters.get(i).center_x)) > 2
					|| (int) (Math.abs(centroid_x -  clusters.get(i).center_x)) > 2)
			{
				change = true;
			}
			clusters.get(i).center_x = centroid_x;
			clusters.get(i).center_y = centroid_y;
		}
		
		//loops > 3 ??

		if (change == false) // i.e no change in new centers
		{

			// see if centres are not changing and the weight is exceeding for any
			for (int i = 0; i < k; i++) 
			{
				if (clusters.get(i).weightage > 1.5 * average) 
				{
					ArrayList<Vendor1> a_new = new ArrayList<Vendor1>();
					Integer knew1 = 0;
					ArrayList<cluster> child_clusters;
					Iterator<Vendor1> it = clusters.get(i).members.iterator();
					while (it.hasNext()) 
					{
						//unit u = new unit();
						Vendor1 temp = it.next();
						//u.g.x = temp.g.x;
						//u.g.y = temp.g.y;
						//u.weightage = temp.weightage;
						a_new.add(temp);
					}
					child_clusters = createClusters(a_new, 2, knew1);// check
					
					//again same thing
					if (knew1 > 1) 
					{
						clusters.add(i, child_clusters.get(0));
					}
					for (int j = 1; j < knew1; j++) 
					{
						clusters.add(k, child_clusters.get(j));
						k++;
					}
				}

			}

			k_new = k;
			break;
		} else 
		{

			for (int i = 0; i < k; i++) {
				clusters.get(i).sumx = 0;
				clusters.get(i).sumy = 0;
				clusters.get(i).weightage = 0;
				clusters.get(i).size = 0;
				
				clusters.get(i).clear();
				for (int j = 0; j < asz; j++)
					visited[j] = false;
			}

		}

		loops++;
	} while (loops < 100);

	
	
	int i,j;

	for(i=0;i<clusters.size();i++)
		{
		//	
		if(clusters.get(i).members.size()==0)
				{
			clusters.remove(clusters.get(i));
			i--;
				}
		//if(i>=clusters.size()) break;
			
		}
	
	int flag_compute_clusters_again=0;
		do
		{
		
		
		for(i=0;i<clusters.size();i++)
		{
			clusters.get(i).core_category_count=0;
		}
		for(i=0;i<clusters.size();i++)
		{
			int pest=0,plumb=0,elect=0,carpent=0,patho=0,physio=0,pet=0,nursing=0;
			for(j=0;j<clusters.get(i).members.size();j++)
			{
			//	System.out.println(" service -- "+clusters.get(i).members.get(j).service);
				
				
				
				Vendor1 v1= vendor1Dao.getById(clusters.get(i).members.get(j).getId());
				List<VendorService1> vs1=vendorservice1Dao.getServicesForVendor(String.valueOf(v1.getId()));
				
				int m;
				for(m=0;m<vs1.size();m++)
				{
				Service1 s1=service1Dao.getById(vs1.get(k).getServiceId());
				if(s1.getName().equals("Pest Control")&&pest==0)
				{
				//	System.out.println("match1");
					clusters.get(i).core_category_count++;
					pest=1;
				}
				
				if(s1.getName().equals("Plumber")&&plumb==0)
				{
				//	System.out.println("match2");
					clusters.get(i).core_category_count++;
					plumb=1;
				}
				if(s1.getName().equals("Electrician")&&elect==0)
				{
				//	System.out.println("match3");
					clusters.get(i).core_category_count++;
				    elect=1;	
				}
				if(s1.getName().equals("Carpentry")&&carpent==0)
				{	
				//	System.out.println("match4");
					clusters.get(i).core_category_count++;
					carpent=1;
				}
				if(s1.getName().equals("Pathology")&&patho==0)
				{
				//	System.out.println("match5");
					clusters.get(i).core_category_count++;
					patho=1;
				}
				if(s1.getName().equals("PhysioTherapy")&&physio==0)
				{
					//System.out.println("match6");
					clusters.get(i).core_category_count++;
					physio=1;
				}	
				if(s1.getName().equals("Pet Care")&&pet==0)
				{
				//	System.out.println("match7");
					clusters.get(i).core_category_count++;
					pet=1;
				}
				if(s1.getName().equals("Nursing Care")&&nursing==0)
				{
				//	System.out.println("match8");
					clusters.get(i).core_category_count++;
				    nursing=1;	
				}
				
			}
				
			}
		}
		
		
			
			
		
		
		flag_compute_clusters_again=0;
		for(i=0;i<clusters.size();i++)
		{
			
		//System.out.println("cluster index "+i+" count "+clusters.get(i).core_category_count);
		    if(clusters.get(i).core_category_count!=8)
		    {
		    	flag_compute_clusters_again=1;
		    	break;
		    }
		    	
			
			
		//	for(j=0;j<clusters.get(i).members.size();j++)
		//	{
		//		System.out.println("service "+clusters.get(i).members.get(j).service);
		//	}
			
		}
		
		//System.out.println("no of clusters begin now is "+clusters.size());
		
		if(flag_compute_clusters_again==0) break;
		
		int min_cluster_index=-1;
		int max_count=100;
		for(i=0;i<clusters.size();i++)
		{
			
		if(clusters.get(i).core_category_count<max_count )
		{
			max_count=clusters.get(i).core_category_count;
			min_cluster_index=i;
		}	
		}
	//	System.out.println("min cluster index is "+min_cluster_index);
		double min_distance=99999999;
		int nearest_cluster=-1;
	//	System.out.println("no of clusters now is "+clusters.size());
		for(i=0;i<clusters.size();i++)
		{
			if(clusters.get(i).members.size()==0) continue;
			if(i==min_cluster_index) continue;
			geotag clustermin=new geotag();
			
		//	System.out.println("minnn cluster index is "+min_cluster_index);
		//	System.out.println("minnn cluster index center x is "+clusters.get(min_cluster_index).center_x);
			clustermin.x=clusters.get(min_cluster_index).center_x;
			clustermin.y=clusters.get(min_cluster_index).center_y;
			
			geotag clusterg=new geotag();
			clusterg.x=clusters.get(i).center_x;
			clusterg.y=clusters.get(i).center_y;
		//	System.out.println("in these cases bro");
		//	System.out.println("min distance is "+min_distance);
		//	System.out.println("cluster g "+clusterg.x+" "+clusterg.y);
		//	System.out.println("clustermin g "+clustermin.x+" "+clustermin.y);
		//	System.out.println("geo distance is "+VendorDistanceComparator.Distance(clusterg,clustermin ));
			if(VendorDistanceComparator.Distance(clusterg,clustermin )<min_distance)
			{
				min_distance=VendorDistanceComparator.Distance(clusterg,clustermin );
			    nearest_cluster=i;
			}
		}
	//	System.out.println("nearest cluster is "+nearest_cluster);
		
	//	if(clusters.size()==1) break;
		clusters=merge(clusters,nearest_cluster,min_cluster_index);
		
		
		}while(flag_compute_clusters_again==1);




	for(i=0;i<clusters.size() ;i++)
	{
		if(clusters.get(i).members.size()>0)
		{
			Cluster1 c1=new Cluster1();
		
			c1.setLatitude(clusters.get(i).center_x);
			c1.setLongitude(clusters.get(i).center_y);
		    cluster1Dao.save(c1);	
			
		for(j=0;j<clusters.get(i).members.size();j++)
		{
			clusters.get(i).members.get(j).setClusterId(c1.getId());
			vendor1Dao.save(clusters.get(i).members.get(j));
		}
	
		}
	}
	
	return clusters ;// space for
}




private static ArrayList<cluster> merge(ArrayList<cluster> clusters,
		int nearest_cluster, int min_cluster_index) {
	
	
	// TODO Auto-generated method stub
	
	int i;
	//System.out.println("nearest cluster is "+nearest_cluster);
	for(i=0;i<clusters.get(nearest_cluster).members.size();i++)
	{
		clusters.get(min_cluster_index).addAs_bunit(clusters.get(nearest_cluster).members.get(i));
		clusters.get(min_cluster_index).add(clusters.get(nearest_cluster).members.get(i));
	}
	
	clusters.get(min_cluster_index).sumx = 0;
	clusters.get(min_cluster_index).sumy = 0;
	clusters.get(min_cluster_index).size = 0;
	
	for(i=0;i<clusters.get(min_cluster_index).members.size();i++)
	{
	clusters.get(min_cluster_index).sumx += clusters.get(min_cluster_index).members.get(i).getLatitude();
	clusters.get(min_cluster_index).sumy += clusters.get(min_cluster_index).members.get(i).getLongitude();
	clusters.get(min_cluster_index).size += 1;
	}
	
	clusters.get(min_cluster_index).center_x = clusters.get(min_cluster_index).sumx/ (double) clusters.get(min_cluster_index).size;
	clusters.get(min_cluster_index).center_y = clusters.get(min_cluster_index).sumy/ (double) clusters.get(min_cluster_index).size;
	
	
	clusters.remove(nearest_cluster);
	return clusters;
}


int find_neighbourhood(geotag cust_g)
{
    List<Cluster1> clusters=cluster1Dao.getAll();
	int i;
	double max_dist=9999;
	int cluster_index=-1;
	for(i=0;i<clusters.size();i++)
	{
		geotag cluster_center=new geotag();
		cluster_center.x=clusters.get(i).getLatitude();
		cluster_center.y=clusters.get(i).getLongitude();
		if(VendorDistanceComparator.Distance(cust_g, cluster_center)<max_dist)
		{
			max_dist=VendorDistanceComparator.Distance(cust_g, cluster_center);
			cluster_index=i;
		}
		
	}
	
	return clusters.get(cluster_index).getId();
}



// AMAL MODIFY 
public  List<VendorLocation> getNearByVendors(List<VendorLocation> inputLocs,geotag cust_g)
{
	
		List<VendorLocation> results_locations = new ArrayList<VendorLocation>();
	int i=0;
	for(i=0;i<inputLocs.size();i++)
	{
		geotag vend_loc=new geotag();
		vend_loc.x=inputLocs.get(i).latitude;
		vend_loc.y=inputLocs.get(i).longitude;
		if(Distance(cust_g,vend_loc)<3)
		{
			results_locations.add(inputLocs.get(i));
		}
	}
	
	
	
	
	return results_locations;
	
	
	
	
}

public ArrayList<Vendor1> getRankedVendors(int cluster_id,int service_id,geotag cust_g)
{
	List<Vendor1> vendors_list=vendor1Dao.getByClusterId(cluster_id);
	ArrayList<Vendor1> result_vendors=new ArrayList<Vendor1>();
	
	
	int i,j;
	for(i=0;i<vendors_list.size();i++)
	{
		List<VendorService1> vendorservicelist=vendorservice1Dao.getServicesForVendor(vendors_list.get(i).getId());
	   
		for(j=0;j<vendorservicelist.size();j++)
		{
			
			if(vendorservicelist.get(j).getServiceId()==service_id)
			{
				
				result_vendors.add(vendors_list.get(i));
			}
		}
	   
	}
	
	VendorDistanceComparator vendordistcomp=new VendorDistanceComparator();
	vendordistcomp.cust_geo=cust_g;
    Collections.sort(result_vendors, vendordistcomp);
	
	
	
	
	
	
	return result_vendors;
	
	
}


public ArrayList<geotag> getRandomGeotags(geotag g, int number)
	{
		double distance =2;
		double radius=6371.01;
		
		double radLat=deg2rad(g.x);
		double radLon=deg2rad(g.y);
		
		double radDist = distance / radius;

		double minLat = radLat - radDist;
		double maxLat = radLat + radDist;

		double minLon, maxLon;
		if (minLat > MIN_LAT && maxLat < MAX_LAT) {
			double deltaLon = Math.asin(Math.sin(radDist) /
				Math.cos(radLat));
			minLon = radLon - deltaLon;
			if (minLon < MIN_LON) minLon += 2d * Math.PI;
			maxLon = radLon + deltaLon;
			if (maxLon > MAX_LON) maxLon -= 2d * Math.PI;
		} else {
			// a pole is within the distance
			minLat = Math.max(minLat, MIN_LAT);
			maxLat = Math.min(maxLat, MAX_LAT);
			minLon = MIN_LON;
			maxLon = MAX_LON;
		}
		
		geotag temp1_g=new geotag();
		temp1_g.x=rad2deg(minLat);
		temp1_g.y=rad2deg(minLon);
		
		
		
		geotag temp2_g=new geotag();
		temp2_g.x=rad2deg(maxLat);
		temp2_g.y=rad2deg(maxLon);
		
		
		geotag temp3_g=new geotag();
		temp3_g.x=rad2deg(maxLat);
		temp3_g.y=rad2deg(minLon);
		
		geotag temp4_g=new geotag();
		temp4_g.x=rad2deg(minLat);
		temp4_g.y=rad2deg(maxLon);
		
		
		ArrayList<geotag> results=new ArrayList<geotag>();
		
		results.add(temp1_g);
		results.add(temp2_g);
		results.add(temp3_g);
		results.add(temp4_g);
		
		int i;
		
		for(i=0; i< (number - 4); i++)
		{
			geotag temp_g=new geotag();
		double lamd1=new Random().nextDouble();
		double lamd2=new Random().nextDouble();
		double lamd3=new Random().nextDouble();
		double lamd4=1-lamd1-lamd2-lamd3;
		
		temp_g.x=lamd1*temp1_g.x+lamd2*temp2_g.x+lamd3*temp3_g.x+lamd4*temp4_g.x;
		temp_g.y=lamd1*temp1_g.y+lamd2*temp2_g.y+lamd3*temp3_g.y+lamd4*temp4_g.y;
		results.add(temp_g);
		}
		return results;
	}


public  void generateGeoCoordinates()
{
	List<Vendor1> vendorlist = vendor1Dao.getAll();
	GeoMain gm = new GeoMain();
	for(Vendor1 v1 : vendorlist)
	{

	  GeoTag latlong =  gm.getAddr(v1.getAddress());
		if(latlong != null)
		{
			v1.setLatitude( latlong.x);
			v1.setLongitude( latlong.y);
			vendor1Dao.save(v1);
		}

	}
}



}
