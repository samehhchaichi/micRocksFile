<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>springboot-javafx</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <name>Spring Boot JavaFX App</name>

    <properties>
        <java.version>17</java.version>
        <spring-boot.version>3.1.2</spring-boot.version>
        <javafx.version>21</javafx.version>
    </properties>

    <dependencies>
        <!-- Spring Boot Core (sans Spring Web, car c'est une app Desktop) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
            <version>${spring-boot.version}</version>
        </dependency>

        <!-- JavaFX -->
        <dependency>
            <groupId>org.openjfx</groupId>
            <artifactId>javafx-controls</artifactId>
            <version>${javafx.version}</version>
        </dependency>
        <dependency>
            <groupId>org.openjfx</groupId>
            <artifactId>javafx-fxml</artifactId>
            <version>${javafx.version}</version>
        </dependency>

        <!-- Gestion des fichiers YAML pour lire les config des services -->
        <dependency>
            <groupId>org.yaml</groupId>
            <artifactId>snakeyaml</artifactId>
            <version>2.0</version>
        </dependency>

        <!-- Logging -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>2.0.7</version>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>1.4.7</version>
        </dependency>

        <!-- Spring Boot Test (au cas où) -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- Spring Boot Maven Plugin -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>

            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                </configuration>
            </plugin>

            <!-- JavaFX Plugin pour exécuter l'application JavaFX -->
            <plugin>
                <groupId>org.openjfx</groupId>
                <artifactId>javafx-maven-plugin</artifactId>
                <version>${javafx.version}</version>
                <executions>
                    <execution>
                        <id>default-cli</id>
                        <goals>
                            <goal>run</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>

            <!-- Maven Shade Plugin pour créer un JAR exécutable -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.2.4</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>com.example.MainApp</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>


<plugin>
    <groupId>org.openjfx</groupId>
    <artifactId>javafx-maven-plugin</artifactId>
    <version>${javafx.version}</version>
    <executions>
        <execution>
            <id>default-cli</id>
            <goals>
                <goal>run</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <mainClass>com.example.MainApp</mainClass>  <!-- Remplace par ta classe JavaFX principale -->
    </configuration>
</plugin>

package com.example;

import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.stage.DirectoryChooser;
import javafx.stage.Stage;

import java.io.File;

public class Controller {

    @FXML
    private TextField directoryField;

    @FXML
    private TableView<Service> serviceTable;

    @FXML
    private Button startButton, stopButton, logsButton;

    private Stage primaryStage;

    public void setPrimaryStage(Stage primaryStage) {
        this.primaryStage = primaryStage;
    }

    @FXML
    private void handleBrowseDirectory() {
        DirectoryChooser directoryChooser = new DirectoryChooser();
        directoryChooser.setTitle("Sélectionner un dossier de projets Spring Boot");
        File selectedDirectory = directoryChooser.showDialog(primaryStage);

        if (selectedDirectory != null) {
            directoryField.setText(selectedDirectory.getAbsolutePath());
            // TODO: Scanner ce dossier pour trouver les services Spring Boot
        }
    }

    @FXML
    private void handleStartServices() {
        // TODO: Implémenter le démarrage des services
    }

    @FXML
    private void handleStopAllServices() {
        // TODO: Implémenter l'arrêt de tous les services
    }

    @FXML
    private void handleShowLogs() {
        // TODO: Implémenter l'affichage des logs d'un service sélectionné
    }
}

package com.example;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

import java.io.IOException;

public class MainApp extends Application {

    @Override
    public void start(Stage primaryStage) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/views/main-view.fxml"));
            BorderPane root = loader.load();

            Controller controller = loader.getController();
            controller.setPrimaryStage(primaryStage);

            Scene scene = new Scene(root, 800, 600);
            primaryStage.setTitle("Gestionnaire de Services Spring Boot");
            primaryStage.setScene(scene);
            primaryStage.show();
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Erreur lors du chargement de l'interface FXML");
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}


<?xml version="1.0" encoding="UTF-8"?>

<?import javafx.scene.control.*?>
<?import javafx.scene.layout.*?>
<?import javafx.geometry.Insets?>

<BorderPane xmlns:fx="http://javafx.com/fxml/1"
            fx:controller="com.example.Controller">

    <!-- Barre du haut : Sélection du dossier -->
    <top>
        <HBox spacing="10">
            <padding>
                <Insets top="10" right="10" bottom="10" left="10"/>
            </padding>
            <Label text="📂 Dossier des projets : " />
            <TextField fx:id="directoryField" promptText="Sélectionnez un dossier..." prefWidth="400" />
            <Button text="📁 Parcourir" onAction="#handleBrowseDirectory" />
        </HBox>
    </top>

    <!-- Centre : Tableau des services -->
    <center>
        <TableView fx:id="serviceTable">
            <columns>
                <TableColumn text="✅" fx:id="selectColumn" />
                <TableColumn text="Nom du Service" fx:id="nameColumn" />
                <TableColumn text="Port" fx:id="portColumn" />
                <TableColumn text="Statut" fx:id="statusColumn" />
                <TableColumn text="Actions" fx:id="actionColumn" />
            </columns>
        </TableView>
    </center>

    <!-- Bas : Boutons d'action -->
    <bottom>
        <HBox spacing="10">
            <padding>
                <Insets top="10" right="10" bottom="10" left="10"/>
            </padding>
            <Button text="▶️ Démarrer sélectionnés" fx:id="startButton" disable="true" onAction="#handleStartServices" />
            <Button text="🛑 Tout arrêter" fx:id="stopButton" disable="true" onAction="#handleStopAllServices" />
            <Button text="🔍 Voir logs" fx:id="logsButton" disable="true" onAction="#handleShowLogs" />
        </HBox>
    </bottom>

</BorderPane>

package com.example;

import javafx.beans.property.SimpleStringProperty;

public class Service {
    private final SimpleStringProperty name;
    private final SimpleStringProperty port;
    private final SimpleStringProperty status;

    public Service(String name, String port, String status) {
        this.name = new SimpleStringProperty(name);
        this.port = new SimpleStringProperty(port);
        this.status = new SimpleStringProperty(status);
    }

    public String getName() { return name.get(); }
    public void setName(String value) { name.set(value); }

    public String getPort() { return port.get(); }
    public void setPort(String value) { port.set(value); }

    public String getStatus() { return status.get(); }
    public void setStatus(String value) { status.set(value); }
}

package com.example;

import org.yaml.snakeyaml.Yaml;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

public class ServiceScanner {

    public static List<Service> scanForServices(File rootDir) {
        List<Service> services = new ArrayList<>();

        if (rootDir != null && rootDir.isDirectory()) {
            for (File subDir : Objects.requireNonNull(rootDir.listFiles(File::isDirectory))) {
                File pomFile = new File(subDir, "pom.xml");
                File configFile = new File(subDir, "config-local/application-dev.yml");

                if (pomFile.exists() && configFile.exists()) {
                    String artifactId = extractArtifactId(pomFile);
                    String port = extractServerPort(configFile);
                    services.add(new Service(artifactId, port, "🔴 Stoppé"));
                }
            }
        }
        return services;
    }

    private static String extractArtifactId(File pomFile) {
        try (Scanner scanner = new Scanner(pomFile)) {
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine().trim();
                if (line.startsWith("<artifactId>")) {
                    return line.replaceAll("<artifactId>(.*?)</artifactId>", "$1").trim();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "Inconnu";
    }

    private static String extractServerPort(File configFile) {
        try (FileInputStream fis = new FileInputStream(configFile)) {
            Yaml yaml = new Yaml();
            Map<String, Object> config = yaml.load(fis);
            if (config.containsKey("server.port")) {
                return config.get("server.port").toString();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "8080"; // Port par défaut
    }
}



@FXML
private void handleBrowseDirectory() {
    DirectoryChooser directoryChooser = new DirectoryChooser();
    directoryChooser.setTitle("Sélectionner un dossier de projets Spring Boot");
    File selectedDirectory = directoryChooser.showDialog(primaryStage);

    if (selectedDirectory != null) {
        directoryField.setText(selectedDirectory.getAbsolutePath());
        List<Service> services = ServiceScanner.scanForServices(selectedDirectory);
        serviceTable.getItems().setAll(services);
    }
}

