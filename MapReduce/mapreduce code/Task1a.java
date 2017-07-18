
import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

//1 a) Is the number of petitions with Data Engineer job title increasing over time?
public class Task1a {

	public static class map1a extends Mapper<LongWritable, Text, Text, Text> {
		public void map(LongWritable key, Text value, Context con)
				throws IOException, InterruptedException {
			String[] str = value.toString().split("\t");
						
				String year = str[7];
				String job_title = str[4];
				String petition =str[2];
				if (str[4].equals("DATA ENGINEER")) {
					con.write(new Text(year), new Text(petition));
			
			}
		}
	}
	
	public static class reducer1a extends Reducer<Text,Text,Text,IntWritable>
	{
		public void reduce(Text key,Iterable<Text> value,Context con) throws IOException, InterruptedException
		{
			int count=0;
			for(Text val:value)
			{
				count++;
			}
		con.write(key,new IntWritable(count));
		}
	}
	
	public static void main(String[] args) throws IllegalArgumentException,
			IOException, ClassNotFoundException, InterruptedException {
		Configuration con = new Configuration();
		Job job = Job.getInstance(con, "");
		job.setJarByClass(Task1a.class);
		job.setMapperClass(map1a.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(Text.class);
		job.setReducerClass(reducer1a.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		
		FileInputFormat.setInputPaths(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}