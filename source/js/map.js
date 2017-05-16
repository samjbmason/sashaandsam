const mapbox = window.mapboxgl
import _ from 'lodash'
import moment from 'moment'

mapbox.accessToken = 'pk.eyJ1Ijoic2pibWFzb24iLCJhIjoiY2lyOWlremowMDAzaGlsbHcxc3M1MjN5MiJ9.d0PR9m9xj440HmPRF5g_5w'

const allPlaces = [
  {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: [-123.039202, 49.262630]
    },
    properties: {
      title: 'Mapbox DC',
      icon: 'marker',
      dateLeaving: '17/08/2016'
    }
  },
  {
    type: 'Feature',
    geometry: {
      type: 'Point',
      coordinates: [-122.344376, 47.613389]
    },
    properties: {
      title: 'Mapbox DC',
      icon: 'marker',
      dateLeaving: '18/08/2016'
    }
  }
]

const filteredPlaces = _.filter(allPlaces, dateFilter)

function dateFilter (place) {
  console.log(place)
  const leavingDate = place.properties.dateLeaving
  const parsedDate = moment(leavingDate, "DD/MM/YYYY")
  const currentDate = moment('10/08/2016', 'DD/MM/YYYY')
  return parsedDate.isSameOrBefore(currentDate)
}

console.log(filteredPlaces)

const map = new mapbox.Map({
  container: 'travel-map',
  style: 'mapbox://styles/sjbmason/cir9o3cf0000th1kp459lnjp1',
  center: [-123.039202, 49.262630],
  zoom: 9
})

map.on('load', () => {
  map.addSource('places', {
    type: 'geojson',
    data: {
      type: 'FeatureCollection',
      features: allPlaces
    }
  })

  map.addLayer({
    id: 'places',
    type: 'symbol',
    source: 'places',
    "layout": {
        "icon-image": "{icon}-15",
        "icon-opacity": 0.5,
        "text-field": "{title}",
        "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
        "text-offset": [0, 0.6],
        "text-anchor": "top"
    }
  })
})

export default map
