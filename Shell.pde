void generateShell(int n, int m)
{  
  // adjust resolution of mesh for number of shell turns
  n = (int) ( n * turns / 10.0);

  spiral = new PVector[n];
  shell = new PVector[n][m];

  // Get vertices for the shell
  for (int i = 0; i < n; i++) 
  {
    // Generate main spiral
    float theta = map(i, 0, n, 0, turns);
    float rad = (exp( theta * cos(alpha) / sin(alpha) ));

    //float Axy =(kxy*theta)+offset; //Axy tunes the rate the spiral opens
    //float Az = k*theta; //Az tunes the rate the spiral lengthens

    float x =  ((kxy * theta) + offset_xy) * rad * sin(beta) * cos(theta) * D;
    float y =  ((kxy * theta) + offset_xy) * rad * sin(beta) * sin(theta);
    float z = -((k * theta) + offset_z) * rad * cos(beta);

    spiral[i] = new PVector(x, y, z);

    // Generate ellipse around each point of spiral
    for (int j = 0; j < m; j++) 
    {
      float s = map(j, 0, m, 0, TWO_PI);  

      float  ripple_a = a + ( ripple_depth + ripple_depth * ( sin( theta * ripple_freq) ) );
      float  ripple_b = b + ( ripple_depth + ripple_depth * ( cos( theta * ripple_freq) ) );
      float r2 = pow( pow(cos(s)/ripple_a, 2) + pow(sin(s)/ripple_b, 2), -0.5 );

      // add surface manipulations
      float surfrad_1 = 0;
      float surfrad_2 = 0;
      float surfrad_3 = 0;
      float surfrad_4 = 0;
      float surfrad_5 = 0;

      //spike/ridge #1
      if (W1_1==0 || W2_1==0 || N==0) surfrad_1 = 0;
      else {
        float lt_1 = ((TWO_PI / N) + N_1) * ( N*theta / TWO_PI - int(N*theta / TWO_PI) );
        surfrad_1 = L_1 * exp( -( pow(2*(s-P_1)/( pow( sin(lt_1), W1_1 ) ), 2) + pow(2*lt_1/W2_1, 2) ) );
      }

      //spike/ridge #2
      if (W1_2==0 || W2_2==0 || N==0) surfrad_2 = 0;
      else {
        float lt_2 = ((TWO_PI / N) + N_2) * ( N*theta / TWO_PI - int(N*theta / TWO_PI) );
        surfrad_2 = L_2 * exp( -( pow(2*(s-P_2)/W1_2, 2) + pow(2*lt_2/W2_2, 2) ) );
      }

      //spike/ridge #3
      if (W1_3==0 || W2_3==0 || N==0) surfrad_3 = 0;
      else {
        float lt_3 = ((TWO_PI / N) + N_3) * ( N*theta / TWO_PI - int(N*theta / TWO_PI) );
        surfrad_3 = L_3 * exp( -( pow(2*(s-P_3)/W1_3, 2) + pow(2*lt_3/W2_3, 2) ) );
      }

      //spike/ridge #4
      if (W1_4==0 || W2_4==0 || N==0) surfrad_4 = 0;
      else {
        float lt_4 = ((TWO_PI / N ) + N_4) * ( N*theta / TWO_PI - int(N*theta / TWO_PI) );
        surfrad_4 = L_4 * exp( -( pow(2*(s-P_4)/W1_4, 2) + pow(2*lt_4/W2_4, 2) ) );
      }


      surfrad_5 = ridge_depth*sin(s * ridge_freq);          


      r2 += surfrad_1;
      r2 += surfrad_2;
      r2 += surfrad_3;
      r2 += surfrad_4;
      r2 += surfrad_5;



      // adjust orientation of the elipse

      float wobble_phi = phi + twist_phi*theta +(depth_phi*(sin(theta * freq_phi)));
      float wobble_omega = omega + (depth_omega*(sin(theta * freq_omega)));
      float wobble_mu = mu + (depth_mu*(sin(theta * freq_mu)));

      x = cos(s + wobble_phi) * cos(theta + wobble_omega) * r2 * (rad-1) * D;   // here  rad - 1 closes the opening of the curve at the origin
      y = cos(s + wobble_phi) * sin(theta + wobble_omega) * r2 * (rad-1);
      z = sin(s + wobble_phi)                             * r2 * (rad-1);

      x -= sin(wobble_mu) * sin(s + wobble_phi) * sin(theta + wobble_omega) * r2;
      y += sin(wobble_mu) * sin(s + wobble_phi) * cos(theta + wobble_omega) * r2;
      z *= cos(wobble_mu);

      shell[i][j] = PVector.add(spiral[i], new PVector(x, y, z));
    }
  }
}


// create mesh from above vertex data
void generateMesh(int n, int m)
{
  // adjust resolution of mesh for number of shell turns
  n = (int) (n * turns / 20.0);

  // vertices
  float[][] vertices = new float[ n * m ][3];
  int index = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++) {
      vertices[index][0] = shell[i][j].x;
      vertices[index][1] = shell[i][j].y;
      vertices[index][2] = shell[i][j].z;
      index++;
    }
  }

  // faces
  index = 0;
  int[][] faces = new int[ (n-1)*m ][4];
  for (int j = 0; j < n-1; j++) {
    for (int i = 0; i < m; i++) {
      faces[index][0] = i + m * j;
      faces[index][1] = (i + 1) % m + m * j;
      faces[index][2] = (i + 1) % m + m * (j + 1);
      faces[index][3] = i + m * (j + 1);
      index++;
    }
  }

  // HE_mesh creator
  HEC_FromFacelist creator=new HEC_FromFacelist();
  creator.setVertices(vertices);
  creator.setFaces(faces);
  creator.setDuplicate(false);
  mesh = new HE_Mesh(creator);
}

