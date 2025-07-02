package main

import (
    "net/http"
    "strconv"

    "github.com/gin-gonic/gin"
)

// Car represents a vehicle in our system
type Car struct {
    ID    int    `json:"id"`
    Make  string `json:"make"`
    Model string `json:"model"`
    Year  int    `json:"year"`
}

// In-memory data store
var cars = []Car{
    {ID: 1, Make: "Toyota", Model: "Camry", Year: 2020},
    {ID: 2, Make: "Tesla", Model: "Model 3", Year: 2022},
}

func main() {
    server := gin.Default()

    server.GET("/all", getCars)
    server.GET("/:id", getCarByID)
    server.POST("/add", createCar)
    server.DELETE("/:id", deleteCar)

    server.Run(":2025")
}

// GET /cars
func getCars(c *gin.Context) {
    c.JSON(http.StatusOK, cars)
}

// GET /cars/:id
func getCarByID(c *gin.Context) {
    id, err := strconv.Atoi(c.Param("id"))
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid car ID"})
        return
    }

    for _, car := range cars {
        if car.ID == id {
            c.JSON(http.StatusOK, car)
            return
        }
    }

    c.JSON(http.StatusNotFound, gin.H{"error": "Car not found"})
}

// POST /cars
func createCar(c *gin.Context) {
    var newCar Car
    if err := c.ShouldBindJSON(&newCar); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    newCar.ID = getNextCarID()
    cars = append(cars, newCar)
    c.JSON(http.StatusCreated, newCar)
}

func getNextCarID() int {
    maxID := 0
    for _, car := range cars {
        if car.ID > maxID {
            maxID = car.ID
        }
    }
    return maxID + 1
}

// DELETE /cars/:id
func deleteCar(c *gin.Context) {
    id, err := strconv.Atoi(c.Param("id"))
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid car ID"})
        return
    }

    for i, car := range cars {
        if car.ID == id {
            cars = append(cars[:i], cars[i+1:]...)
            c.JSON(http.StatusOK, gin.H{"message": "Car deleted"})
            return
        }
    }

    c.JSON(http.StatusNotFound, gin.H{"error": "Car not found"})
}
