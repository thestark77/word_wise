import {
  IonAccordion,
  IonAccordionGroup,
  IonAvatar,
  IonButtons,
  IonHeader,
  IonItem,
  IonLabel,
  IonMenuButton,
  IonToolbar
} from '@ionic/react'

import avatar from '../../assets/img/avatar.svg'
import './Header.css'

const Header: React.FC = () => {
  return (
    <IonHeader>
      <IonToolbar>
        <IonMenuButton slot='start' />
        <IonButtons slot='end'>
          <IonLabel>Jose Alejandro Salazar</IonLabel>
          <IonAccordionGroup>
            <IonAccordion>
              <IonItem slot='header' color='light'>
                <IonAvatar className='ion-margin-vertical'>
                  <img className='avataricon' src={avatar} alt='avatar' />
                </IonAvatar>
              </IonItem>
              <div className='ion-padding' slot='content'>
                Mi perfil
              </div>
              <div className='ion-padding' slot='content'>
                Salir
              </div>
            </IonAccordion>
          </IonAccordionGroup>
        </IonButtons>
      </IonToolbar>
    </IonHeader>
  )
}

export default Header
