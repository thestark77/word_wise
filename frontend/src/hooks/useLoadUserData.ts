// import { useCallback, useEffect, useMemo, useState } from 'react'

// const useSingIn = () => {
//   const [datos, setUser] = useState<usuario>(usuarioVacio)

//   //   const userNotFound = useCallback(
//   //     (value: boolean) => {
//   //       if (value) {
//   //         updateStatus({
//   //           showAlert: true,
//   //           showToast: false,
//   //           status: false,
//   //           message: {
//   //             title: 'Error',
//   //             body: 'El número de cédula ingresado no se encuentra registrado'
//   //           }
//   //         })
//   //       }
//   //     },
//   //     [updateStatus]
//   //   )

//   const singIn = useCallback(
//     async (cedula: string | number) => {
//       if (cedula !== 0 && cedula !== '') {
//         await loadUser(setUser, cedula, userNotFound)
//       }
//     },
//     [userNotFound]
//   )

//   useEffect(() => {}, [])

//   useEffect(() => {
//     try {
//       localStorage.setItem('Usuario', JSON.stringify(user))
//     } catch (e) {
//       updateStatus({
//         showAlert: false,
//         showToast: true,
//         status: false,
//         message: {
//           title: 'Error',
//           body: 'No se pudo guardar el usuario, algo anda mal con el caché del dispositivo'
//         }
//       })
//       console.error(`Error: ${e}`)
//     }
//   }, [user, updateStatus])

//   const value = useMemo(() => {
//     return {
//       user,
//       setUser,
//       singIn
//     }
//   }, [user, singIn])

//   return value
// }

// export default useSingIn
