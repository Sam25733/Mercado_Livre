//Inicialização do mapa

const map = L.map('map').setView(
    [-23.455, -46.49], 10
);

// Mapa OpenStreetMap

L.titleLayer(

    'https://{s}.title.openstreetmap.openstreetmap.org/{z}/{x}/{y}.png', {
        atribution: 'OpenStreetMap'
    }
).addTo(map);

// Dados dos veiculos

const vehicles = [
    {
        id: 'FRT-021',
        name: 'fretado 021',
        region: 'Guarulhos',
        lat: -23.4545,
        lng: -46.5333,
        driver: 'Motorista 01'
    },

    {
        id: 'FRT-034',
        name: 'Fretado 034',
        region: 'São Paulo',
        lat: '-23.5200',
        lng: '-46.6100',
        driver: 'Motorista 02'
    },

    {
        id: 'VAN-008',
        name: 'Van 008',
        region: 'Aruja',
        lat: '-23.3970',
        lng: '-46.3200',
        driver: 'Motorista 03'
    },

    {
        id: 'FRT-015',
        name: 'Fretado 015',
        region: 'Itaquaquecetuba',
        lat: '23.4860',
        lng: '46.3480',
        driver: 'Motorista 04',
    }
];

//Dados dos eventos

const eventos = [
    {
        id: 'EVT-101',
        name: 'feira de oportunidades',
        region: 'Guarulhos',
        lat: -23.4628,
        lng: -46.5333,
        date: '12/11/2026'
    },

    {
        id: 'EVT-102',
        name: 'Ação em instituição de ensino',
        region: 'São Paulo',
        lat: -23.4900,
        lng: -46.6200,
        date: '14/11/2026',
    },

    {
        id: 'EVT-103',
        name: 'Mutirão de talentos',
        region: 'Aruja',
        lat: -23.3960,
        lng: -46.3200,
        date: '18/11/2026',
    },

    {
        id: 'EVT-104',
        name: 'Encontro de parceiros',
        region: 'Itaquaquecetuba',
        lat: -23.4860,
        lng: -46.3480,
        date: '20/11/2026',
    }
];

// Camadas do Mapa

const vehicleLayer = L.layergroup().addTo(map);
const eventLayer = L.layergroup().addTo(map);

//Marcadores de Veiculos

vehicles.forEach(vehicle =>{

    const marker = L.marker([
        vehicle.lat,
        vehicle.lng
    ]);

    marker.bindPoup(`
        <h3>${vehicle.name}</h3>
        <P>ID: ${vehicle.id}</p>
        <p>Região: ${vehicle.region}</p>
        <p>Motorista: ${vehicle.driver}</p>
        `);

        vehicleLayer.addLayer(marker);
});

//Marcadores de Evento

EventSource.forEach(event => {

    const marker = L.marker([
        event.lat,
        event.lng
    ]);

    marker.bindPoup(`
        <h3>${event.name}</h3>
        <p>ID:  ${event.id}</p>
        <p>Região:  ${event.region}</p>
        <p>Data:  ${event.date}</p>
        `);

        eventLayer.addLayer(marker);

});

//Filtros

function applyFilters(){
    const region = document.getElementById('regionFilter').value;
    const showVehicles = document.getElementById('showVehicles').value;
    const showEvents = document.getElementById('showEvents').checked;

    vehicleLayer.clearLayers();
    eventLayer.clearLayers();

    const filteredVehicles = vehicles.filter(vehicles =>
        region === 'all' || vehicle.region === region
    );

    const filteredEvents = events.filter(event =>
        region === 'all' || event.region === region
    );

    if (showVehicles){
        filteredVehicles.forEach(vehicles => {

            L.marker([
                vehicle.lat,
                vehicle.lng
            ])
            .bindPoup(`
                <h3>${vehicle.name}</h3>
                <p>${event.region}</p>
                <p>${event.date}</p>
                `)
                .addTo(eventLayer);
        });
    }

    document.getElementById('vehicleCount').textContent = filteredVehicles.length;
    document.getElementById('eventCount').textContent = filteredEvents.length;
    document.getElementById('movingCount').textContent = filteredVehicles.length;
}

//Eventos dos filtros

document.getElementById('regionFilter').addEventListener('change', applyFilters);
document.getElementById('showVehicles').addEventListener('change', applyFilters);
document.getElementById('showEvents').addEventListener('change', applyFilters);