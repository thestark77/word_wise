import { IonPage } from '@ionic/react'
import InicioEstudiante from '../../Tabs/Estudiantes/InicioEstudiante/InicioEstudiante'
import Header from '../../components/Toolbar/Header'
import type { IportalProps } from '../../interfaces'
import './Portal.css'

const Portal: React.FC<IportalProps> = ({ rolUsuario }) => {
  return (
    <IonPage>
      <Header />
      <InicioEstudiante />
    </IonPage>
  )
}

export default Portal
