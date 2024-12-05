// Número de segmentos da "minhoquinha"
int numSegs = 30;
ArrayList<PVector> pontos; // Lista para armazenar as posições dos segmentos
ArrayList<Float> tamanhos; // Lista para armazenar o tamanho dos segmentos
float comprimento = 10; // Tamanho dos segmentos

void setup() {
  size(200, 200);
  pontos = new ArrayList<PVector>();
  tamanhos = new ArrayList<Float>();

  // Adicionando pontos iniciais para a "minhoquinha"
  for (int i = 0; i < numSegs; i++) {
    pontos.add(new PVector(mouseX, mouseY));
    tamanhos.add(comprimento); // Inicia com todos os segmentos com o mesmo tamanho
  }
}

void draw() {
  background(255);
  
  // Atualizando a posição de cada ponto para que "acompanhe" o mouse com atraso suave
  pontos.add(0, new PVector(mouseX, mouseY));  // Adiciona um novo ponto na posição do mouse
  pontos.remove(pontos.size() - 1);            // Remove o último ponto da lista
  
  // Modificar a velocidade de rastreamento dos segmentos
  for (int i = 1; i < pontos.size(); i++) {
    PVector anterior = pontos.get(i - 1);
    PVector atual = pontos.get(i);
    atual.lerp(anterior, 0.2);  // Lerping: aproxima o ponto atual do anterior com 10% de deslocamento
  }
  
  // Desenhando a "minhoquinha"
  noFill();
  for (int i = 0; i < pontos.size() - 1; i++) {
    PVector p1 = pontos.get(i);
    PVector p2 = pontos.get(i + 1);
    
    // Definindo a cor de cada segmento com base no índice
    float cor = map(i, 0, pontos.size() - 1, 0, 255);  // Gradiente de cor
    
    stroke(cor, 100, 255);  // Cor de cada segmento
    strokeWeight(10 + (i % 5));  // Tamanho variável da linha
    line(p1.x, p1.y, p2.x, p2.y); // Conectando os pontos com linhas
    
    // Desenhando círculos ou elipses nos segmentos
    noStroke();
    fill(0, 100, 255, 150); // Cor mais suave e translúcida
    ellipse(p1.x, p1.y, 15 + (i % 3), 15 + (i % 3));  // Tamanho variando
  }
  
  // Garantir que a "minhoquinha" sempre siga o mouse
  pontos.set(0, new PVector(mouseX, mouseY));
}
